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

    def enrollments(user_id:)
      response = get_request("#{ENDPOINT}/#{user_id}/courses")
      Collection.from_response(response, key: "data", type: EnrollmentObject)
    end

    def update(user_id:, **params)
      put_request("#{ENDPOINT}/#{user_id}", params)
      true
    end

    def enroll(user_id:, **attributes)
      post_request("#{ENDPOINT}/#{user_id}/enrollment", attributes)
      true
    end

    def attach_tags(user_id:, tags:)
      put_request("#{ENDPOINT}/#{user_id}/tags", tags: tags, action: 'attach')
      true
    end

    def detach_tags(user_id:, tags:)
      put_request("#{ENDPOINT}/#{user_id}/tags", tags: tags, action: 'detach')
      true
    end
  end
end
