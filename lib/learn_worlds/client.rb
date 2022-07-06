require "faraday"

require_relative "learn_worlds_error"
require_relative "object"

module LearnWorlds
  class Client
    attr_reader :base_url, :client_id, :client_secret
    attr_accessor :access_token, :expires_in

    def initialize(client_id: nil, client_secret: nil, base_url: nil, access_token: nil)
      @client_id = client_id || ENV.fetch('"LEARN_WORLDS_CLIENT_ID"')
      @client_secret = client_secret || ENV.fetch('LEARN_WORLDS_CLIENT_SECRET')
      @base_url = base_url || ENV.fetch('LEARN_WORLDS_BASE_URL')
      @access_token = access_token
    end

    def user
      UserResource.new(self)
    end

    def authentication
      AuthenticationResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(base_url) do |conn|
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.headers = required_headers
      end
    end

    def required_headers
      headers = { 'Lw-Client': client_id }
      headers.merge({ Authorization: "Bearer #{access_token}" }) if access_token

      headers
    end
  end
end
