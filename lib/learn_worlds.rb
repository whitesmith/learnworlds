# frozen_string_literal: true

require_relative "learn_worlds/version"

module LearnWorlds
  autoload :Users, "learn_worlds/users"
  autoload :Object, "learn_worlds/object"
  autoload :Client, "learn_worlds/client"
  autoload :Collection, "learn_worlds/collection"
  autoload :Configuration, "learn_worlds/configuration"

  autoload :UserObject, "learn_worlds/objects/user_object"

  autoload :Resource, "learn_worlds/resource"
  autoload :AuthenticationResource, "learn_worlds/resources/authentication_resource"
  autoload :SingleSignOnResource, "learn_worlds/resources/single_sign_on_resource"
  autoload :UserResource, "learn_worlds/resources/user_resource"

  class << self
    # Instantiate the Configuration singleton
    # or return it.
    def configuration
      @configuration ||= Configuration.new
    end

    # This is the configure block definition.
    # The configuration method will return the
    # Configuration singleton, which is then yielded
    # to the configure block.
    def configure
      yield(configuration)
    end
  end
end
