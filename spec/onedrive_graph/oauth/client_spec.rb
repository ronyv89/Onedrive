# frozen_string_literal: true

require 'onedrive_graph/oauth/client'
RSpec.describe OnedriveGraph::Oauth::Client do
  let(:client) do
    described_class.new(
      'client_id', 'client_secret', 'http://redirect_uri', 'files.read'
    )
  end

  let(:access_token_request_body) do
    {
      client_id: 'client_id', client_secret: 'client_secret',
      code: 'token', grant_type: 'authorization_code',
      redirect_uri: 'http://redirect_uri'
    }
  end

  let(:access_token_request_headers) do
    {
      Accept: '*/*',
      'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type': 'application/x-www-form-urlencoded',
      'User-Agent': 'Faraday v0.12.2'
    }
  end

  let(:access_token_request_response) do
    {
      status: 200,
      body: {
        token_type: 'Bearer',
        expires_in: 3600,
        scope: 'files.read',
        ext_expires_in: 0,
        access_token: 'EwCo...AA==',
        refresh_token: 'eyJh...9323'
      }.to_json,
      headers: {
        'Content-Type': 'application/json'
      }
    }
  end

  let(:access_token_stub) do
    stub_request(:post, 'https://login.microsoftonline.com/common/oauth2/v2.0/token')
      .with(
        body: access_token_request_body,
        headers: access_token_request_headers
      )
      .to_return(access_token_request_response)
  end

  describe '#authorize_url' do
    it 'matches the authorization url' do
      uri = 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize?' \
            'client_id=client_id&' \
            "redirect_uri=#{CGI.escape('http://redirect_uri')}&" \
            'response_type=code&scope=files.read'
      expect(client.authorize_url).to eq(uri)
    end
  end

  describe '#get_access_token' do
    it 'returns an access token' do
      access_token_stub
      expect(client.get_access_token('token')).to be_a(OAuth2::AccessToken)
    end
  end

  describe '#get_access_token_from_hash' do
    it 'returns access token object from access token string' do
      expect(client.get_access_token_from_hash('EwCo...AA==')).to be_a(
        OAuth2::AccessToken
      )
    end
  end
end
