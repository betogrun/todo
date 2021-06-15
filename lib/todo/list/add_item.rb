require 'securerandom'
require 'date'

module Todo
  class List
    class AddItem
      include Dry::Monads[:result, :do]

      def call(title:, repository:)
        validated_title = yield validate_title(title)
        persist(validated_title, repository)
      end

      private

      def validate_title(title)
        return Failure(:invalid_item) if title.to_s.empty?

        Success(title)
      end

      def persist(title, repository)
        changeset = {
          id: SecureRandom.uuid,
          title: title,
          created_at: DateTime.now,
          completed_at: nil
        }
        repository.create(changeset)

        Success()
      end
    end
  end
end
