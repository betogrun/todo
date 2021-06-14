require "test_helper"

class Todo::ListTest < Minitest::Test
  def test_add_item
    repository = Todo::Repository::InMemory
    list = Todo::List.new(repository)
    title = 'Buy milk'

    list.add_item(title: title)

    assert_equal(title, repository.last[:title])
  end

  def test_add_invalid_items
    repository = Todo::Repository::InMemory
    list = Todo::List.new(repository)
    invalid_titles = ['', nil]

    assert_output("Invalid item!\n") do
      invalid_titles.each { |invalid_title| list.add_item(title: invalid_title) }
    end
  end
end
