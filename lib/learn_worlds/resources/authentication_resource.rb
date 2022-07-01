module LearnWorlds
  class AuthenticationResource < Resource
    AUTHENTICATE_ENDPOINT = "/admin/api/oauth2/access_token".freeze
    CLIENT_CREDENTIALS_GRANT_TYPE = "client_credentials".freeze

    def authenticate(method)
      custom_access_token_retrieval

      # everything went well don't need to continue
      return if client.access_token

      case method
      when CLIENT_CREDENTIALS_GRANT_TYPE
        authenticate_with_secret
      end

      # custom method to store the access token until it expires so we don't need to make uneccessary calls
      LearnWorlds.configuration.persist_access_token_method&.call(client.access_token)
    end

    # custom retrieve method can be used if you store the access token on your side until it expires for example
    def custom_access_token_retrieval
      retrieve_access_token_method = LearnWorlds.configuration.retrieve_access_token_method

      return unless retrieve_access_token_method

      retrieved_access_token = retrieve_access_token_method.call
      client.access_token = retrieved_access_token
    end

    def authenticate_with_secret
      # get the access token using the api
      response = post_request(
        AUTHENTICATE_ENDPOINT,
        {
          client_id: client.client_id,
          client_secret: client.client_secret,
          grant_type: CLIENT_CREDENTIALS_GRANT_TYPE
        }
      )
      response_body = Object.new(response.body)
      client.access_token = response_body.tokenData.access_token
    end
  end
end
