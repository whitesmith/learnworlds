module LearnWorlds
  class UserResource < Resource
    ENDPOINT = "/admin/api/v2/users".freeze

    def list(**params)
      response = get_request(ENDPOINT, params)
      Collection.from_response(response, key: "data", type: UserObject)
    end

    def create(**attributes)
      UserObject.new(post_request(ENDPOINT, attributes).body)
    end

    def find(user_id:)
      UserObject.new(get_request("#{ENDPOINT}/#{user_id}").body)
    end

    def update(user_id:, **params)
      put_request("#{ENDPOINT}/#{user_id}", params)
      true
    end

    def enroll(user_id:, **attributes)
      post_request("#{ENDPOINT}/#{user_id}/enrollment", attributes)
      true
    end
  end
end
