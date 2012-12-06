require 'helper'
require 'omniauth-clef'

class StrategyTest < StrategyTestCase
  include OAuth2StrategyTests
end

class ClientTest < StrategyTestCase
  test 'has correct Clef site' do
    assert_equal 'https://clef.io/api/v1', strategy.client.site
  end

  test 'has correct token url' do
    assert_equal 'authorize', strategy.client.options[:token_url]
  end
end

class UidTest < StrategyTestCase
  def setup
    super
    strategy.stubs(:raw_info).returns({ 'id' => '123' })
  end

  test 'returns the id from raw_info' do
    assert_equal '123', strategy.uid
  end
end

class InfoTestOptionalDataPresent < StrategyTestCase
  def setup
    super
    @raw_info ||= { 'email' => 'test@example.com' }
    strategy.stubs(:raw_info).returns(@raw_info)
  end

  test 'returns the email' do
    assert_equal 'test@example.com', strategy.info['email']
  end

  test 'returns the first name' do
    @raw_info['first_name'] = 'Fred'
    assert_equal 'Fred', strategy.info['first_name']
  end

  test 'returns the last name' do
    @raw_info['last_name'] = 'Smith'
    assert_equal 'Smith', strategy.info['last_name']
  end

  test 'returns the phone number' do
    @raw_info['phone_number'] = '1119991111'
    assert_equal '1119991111', strategy.info['phone_number']
  end
end

class InfoTestOptionalDataNotPresent < StrategyTestCase
  def setup
    super
    @raw_info ||= { 'email' => 'test@example.com' }
    strategy.stubs(:raw_info).returns(@raw_info)
  end

  test 'has no first name key' do
    refute_has_key 'first_name', strategy.info
  end

  test 'has no last name key' do
    refute_has_key 'last_name', strategy.info
  end

  test 'has no phone number key' do
    refute_has_key 'phone_number', strategy.info
  end
end

class RawInfoTest < StrategyTestCase
  def setup
    super
    @access_token = stub('OAuth2::AccessToken')
  end

  test 'performs a GET to https://clef.io/api/v1/info' do
    strategy.stubs(:access_token).returns(@access_token)
    @access_token.expects(:get).with('info').returns(stub_everything('OAuth2::Response'))
    strategy.raw_info
  end

  test 'returns a Hash' do
    strategy.stubs(:access_token).returns(@access_token)
    raw_response = stub('Faraday::Response')
    raw_response.stubs(:body).returns('{ "ohai": "thar" }')
    raw_response.stubs(:status).returns(200)
    raw_response.stubs(:headers).returns({'Content-Type' => 'application/json' })
    oauth2_response = OAuth2::Response.new(raw_response)
    @access_token.stubs(:get).with('info').returns(oauth2_response)
    assert_kind_of Hash, strategy.raw_info
    assert_equal 'thar', strategy.raw_info['ohai']
  end

  test 'returns an empty hash when the response is false' do
    strategy.stubs(:access_token).returns(@access_token)
    oauth2_response = stub('OAuth2::Response', :parsed => false)
    @access_token.stubs(:get).with('info').returns(oauth2_response)
    assert_kind_of Hash, strategy.raw_info
  end
end