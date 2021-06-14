require 'securerandom'
require 'date'

module Todo
  class List
    class InvalidItemError < StandardError; end
    class AddItem
      def call(title:, repository:)
        validated_title = validate_title(title)
        persist(validated_title, repository)
      end

      private

      def validate_title(title)
        raise InvalidItemError, 'Invalid item!' if title&.empty?

        title
      end

      def persist(title, repository)
        changeset = {
          id: SecureRandom.uuid,
          title: title,
          created_at: DateTime.now,
          completed_at: nil
        }
        repository.create(changeset)
      end
    end
  end
end
