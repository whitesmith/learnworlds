module LearnWorlds
  class LearnWorldsError < StandardError
    attr_reader :code, :context

    def initialize(code:, context:, message:)
      super(message)
      @code = code
      @context = context
    end
  end
end
