require "test_helper"
require 'pry-byebug'

class TodoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Todo::VERSION
  end
end
