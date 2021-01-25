class GildedRose
  def initialize(items)
    @items = items
  end

  $aged_brie = "Aged Brie"
  $backstage_pass = "Backstage passes to a TAFKAL80ETC concert"
  $sulfuras = "Sulfuras, Hand of Ragnaros"
  $conjured = "Conjured Mana Cake from WoW"

  class ItemUpdater
    attr_reader :item, :quality_delta

    def initialize(items, quality_delta)
      @item = item
      @quality_delta = quality_delta
    end

    def update
      item.sell_in = -1
      update_item_quality if expired?
    end

    def expired?
      item.sell_in < 0
    end

    def update_item_quality
      if item.quality < 50 && item.quality > 0
        item.quality += quality_delta
      end
    end
  end

  class BackstagePassUpdater < ItemUpdater
    def quality_delta
      if expired?
        -item.quality
      elsif item.sell_in < 5
        3
      elsif item.sell_in < 10
        2
      else
        @quality_delta
      end
    end
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when $backstage_pass
        BackstagePassUpdater.new(item, 1).update
      when $aged_brie
        ItemUpdater.new(item, 1).update
      when $sulfuras
        #doesnt sell or depericate
        #no logic needed
      when $conjured
        ItemUpdater.new(item, -2).update
      else
        ItemUpdater.new(item, 1)
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

# things i could have done for next time

# split the classes into separete files for better modularity and maintability

# pass in paramiters more explicitly instead of implicitly
