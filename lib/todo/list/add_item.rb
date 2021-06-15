require 'securerandom'
require 'date'

module Todo
  class List
    class AddItem
      include Dry::Monads[:result, :do]

      def call(title:, repository:)
        title.
          then(&apply(:validate_title)).
          then(&apply(:persist, with: [repository]))

        Success()
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

      def apply(name, with: [])
        Proc.new do |arg|
          method_args = [arg]
          method_args = method_args | with if !with.empty?
          yield method(name).call(*method_args)
        end
      end
    end
  end
end
