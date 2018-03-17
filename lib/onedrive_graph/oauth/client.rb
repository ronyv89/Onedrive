# frozen_string_literal: true

require 'oauth2'

module OnedriveGraph
  module Oauth
    # OAuth2 Client
    class Client
      attr_accessor :client_id, :client_secret, :oauth_client, :callback_url,
                    :access_token, :scope, :opts
      # Initializes a new Oauth client for Onedrive
      # @param client_id [String] the OAuth2 client id
      # @param client_secret [String] the OAuth2 client secret
      # @param callback_url [String] the registered callback url
      # @param scope [String] comma separated list of permissions
      def initialize(client_id, client_secret, callback_url, scope, opts = {})
        @client_id = client_id
        @client_secret = client_secret
        @callback_url = callback_url
        @scope = scope
        @opts = opts
        @oauth_client = OAuth2::Client.new(
          client_id, client_secret, options
        )
      end

      # Step 1: URL for OAuth2 authorization of Onedrive
      # @return [String]
      def authorize_url
        oauth_client.auth_code.authorize_url(redirect_uri: callback_url)
      end

      # Step 2: Get access token after authorizing user
      # @param [String] code The value extracted from the callback url param 'code'
      # @return [OAuth2::AccessToken] the access token
      def get_access_token(code)
        @access_token = oauth_client.auth_code.get_token(
          code, redirect_uri: callback_url
        )
      end

      # Alternate Step2: Make an access token from already available data
      # @param [String] token the Access Token value
      # @param [Hash] opts the options to create the Access Token with
      # @option opts [String] :refresh_token (nil) the refresh_token value
      # @option opts [FixNum, String] :expires_in (nil) the number of seconds in which the AccessToken will expire
      # @option opts [FixNum, String] :expires_at (nil) the epoch time in seconds in which AccessToken will expire
      # @option opts [Symbol] :mode (:header) the transmission mode of the Access Token parameter value one of :header, :body or :query
      # @option opts [String] :header_format ('Bearer %s') the string format to use for the Authorization header
      # @option opts [String] :param_name ('access_token') the parameter name to use for transmission of the Access Token value in :body or :query transmission mode
      # @return [OAuth2::AccessToken] the access token
      def get_access_token_from_hash(token, opts = {})
        @access_token = OAuth2::AccessToken.new(oauth_client, token, opts)
      end

      private

      def options
        @options = {
          site: 'https://login.microsoftonline.com/common/oauth2/v2.0/',
          authorize_url: "authorize?response_type=code&scope=#{scope}",
          token_url: 'token',
          parse_json: true
        }.merge(opts)
      end
    end
  end
end
