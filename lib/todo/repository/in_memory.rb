module Todo
  module Repository
    module InMemory
      include Todo::Repository

      DB = []

      def self.create(item)
        DB << item
      end

      def self.last
        DB.last
      end

      private_constant :DB
    end
  end
end
