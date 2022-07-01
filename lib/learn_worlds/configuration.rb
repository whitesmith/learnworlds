module LearnWorlds
  class Configuration
    attr_reader :retrieve_access_token_method, :persist_access_token_method

    def initialize
      @retrieve_access_token_method = nil
      @persist_access_token_method = nil
    end

    def retrieve_access_token_method=(lambda)
      raise ArgumentError, "The key_name must be a lambda" unless lambda.is_a?(Proc)

      @retrieve_access_token_method = lambda
    end

    def persist_access_token_method=(lambda)
      raise ArgumentError, "The key_name must be a lambda" unless lambda.is_a?(Proc)

      @persist_access_token_method = lambda
    end
  end
end
