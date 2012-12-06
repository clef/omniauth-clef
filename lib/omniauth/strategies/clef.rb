require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Clef < OmniAuth::Strategies::OAuth2

      option :name, "Clef"
      option :client_options, {
        :site => 'https://clef.io/api/v1',
        :token_url => '/authorize'
      }

      uid { raw_info['id'] }

      info do
        prune!({
          'email' => raw_info['email'],
          'first_name' => raw_info['first_name'],
          'last_name' => raw_info['last_name'],
          'phone_number' => raw_info['phone_number'],
        })
      end

      extra do
        hash = {}
        hash['raw_info'] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get('/info').parsed || {}
        @raw_info = @raw_info['info'] if !@raw_info['info'].nil?
        @raw_info
      end

      private

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end