module LearnWorlds
  class SingleSignOnResource < Resource
    SSO_ENDPOINT = "/admin/api/sso".freeze

    def redirect(email:, redirect_to:)
      post_request(SSO_ENDPOINT, { email: email, redirectUrl: redirect_to }).body['url']
    end

    def redirect_with_id(user_id:, redirect_to:)
      post_request(SSO_ENDPOINT, { user_id: user_id, redirectUrl: redirect_to }).body['url']
    end
  end
end
