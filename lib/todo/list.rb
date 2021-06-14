module Todo
  class List
    def initialize(repository)
      @repository = repository
    end

    def add_item(title:)
      AddItem.new.(title: title, repository: @repository)
    rescue InvalidItemError => e
      puts e.message
    end
  end
end
