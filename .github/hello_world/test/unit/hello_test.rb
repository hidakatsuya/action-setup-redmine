require_relative '../test_helper'

class HelloTest < ActiveSupport::TestCase
  def test_world
    Hello.create world: "Redmine"
    assert_equal "Redmine", Hello.first.world
  end
end
