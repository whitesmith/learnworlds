module LearnWorlds
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get_request(url, params = {}, headers = {})
      handle_response client.connection.get(url, params, default_headers.merge(headers))
    end

    def post_request(url, body = {}, headers = {})
      handle_response client.connection.post(url, body, default_headers.merge(headers))
    end

    def patch_request(url, body = {}, headers = {})
      handle_response client.connection.patch(url, body, default_headers.merge(headers))
    end

    def put_request(url, body = {}, headers = {})
      handle_response client.connection.put(url, body, default_headers.merge(headers))
    end

    def delete_request(url, params = {}, headers = {})
      handle_response client.connection.delete(url, params, default_headers.merge(headers))
    end

    def handle_response(response)
      response_body = response.body
      response_body = JSON.parse(response_body) if response_body.instance_of?(String)
      handle_errors(response_body)

      response
    end

    def handle_errors(response_body)
      error = response_body["errors"]&.first || {}

      error_message = error["message"] || response_body["error"]
      error_context = error["context"]
      error_code = error["code"]

      return if error_message.nil?

      raise LearnWorldsError.new(message: error_message, context: error_context, code: error_code)
    end

    def default_headers
      headers = { 'Lw-Client': client.client_id }
      headers.merge!({ Authorization: "Bearer #{client.access_token}" }) if client.access_token

      headers
    end
  end
end
