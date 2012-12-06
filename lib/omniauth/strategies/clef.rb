require 'omniauth-oauth2'
require 'pry'

module OmniAuth
  module Strategies
    class Clef < OmniAuth::Strategies::OAuth2

      option :name, "Clef"
      option :client_options, {
        :site => 'https://clef.io/api/v1',
        :token_url => 'authorize'
      }
      option :provider_ignores_state, true
      option :auth_token_params, {
        param_name: 'access_token',
        mode: :query
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

      def build_access_token
        verifier = request.params['code']
        client.auth_code.get_token(verifier, {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      end

      def raw_info
        @raw_info ||= access_token.get('info').parsed || {}
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