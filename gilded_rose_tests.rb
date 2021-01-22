require File.join(File.dirname(__FILE__), "gilded_rose")
require "test/unit"

class TestUntitled < Test::Unit::TestCase
  def test_update_quality
    items = [Item.new("update quality test", 0, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "update quality test"
  end
end
