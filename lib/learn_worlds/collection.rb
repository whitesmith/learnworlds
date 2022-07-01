module LearnWorlds
  class Collection
    attr_reader :data, :total, :next_cursor, :prev_cursor

    def self.from_response(response, key:, type:)
      body = response.body
      puts body.class
      new(
        data: body[key].map { |attrs| type.new(attrs) },
        total: body.dig("meta", "totalItems"),
        current_page: body.dig("meta", "page"),
        total_pages: body.dig("meta", "totalPages").to_i
      )
    end

    def initialize(data:, total:, current_page:, total_pages:)
      @data = data
      @total = total
      @current_page = current_page
      @total_pages = total_pages
    end
  end
end
