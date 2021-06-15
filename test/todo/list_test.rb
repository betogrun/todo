require "test_helper"

class Todo::ListTest < Minitest::Test
  def test_add_item
    repository = Todo::Repository::InMemory
    list = Todo::List.new(repository)
    title = 'Buy milk'

    result = list.add_item(title: title)

    assert result.success?
    assert_equal(title, repository.last[:title])
  end

  def test_add_invalid_items
    repository = Todo::Repository::InMemory
    list = Todo::List.new(repository)
    invalid_titles = ['', nil]

    invalid_titles.each do |invalid_title|
      result = list.add_item(title: invalid_title)
      assert result.failure?
    end
  end
end
