# frozen_string_literal: true

module OnedriveGraph
  # Base client
  class Client
    attr_reader :access_token
    include HTTMultiParty
    # include Operations
    base_uri 'https://graph.microsoft.com/v1.0/'
    format :json
    def initialize(access_token)
      @access_token = access_token
      self.class.headers(Authorization: "bearer #{access_token}")
    end
  end
end
