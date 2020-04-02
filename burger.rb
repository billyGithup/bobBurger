require './bun'
require './meat'
require './vegetable'

class Burger
  attr_reader :bun, :meat, :vegetable

  def initialize(bun_obj, meat_obj, vegetable_obj)
    begin
      raise "Make sure variable bun is a Bun class object." unless bun_obj.is_a?(Bun)
      raise "Make sure variable meat is a Meat class object." unless meat_obj.is_a?(Meat)
      raise "Make sure variable vegetable is a Vegetable class object." unless vegetable_obj.is_a?(Vegetable)
    rescue => e
      puts e
      exit
    end
    @bun = bun_obj
    @meat = meat_obj
    @vegetable = vegetable_obj
  end

  def display_burger_info
    puts "The burger has #{bun.name} bun, #{meat.name} meat, and #{vegetable.get_all_names} for vegetables."
  end
end

bun = Bun.new("aaa", 1.99)
meat = Meat.new("bbb", 1.75)
vegetable = Vegetable.new([
                              {"lll" => 2.11},
                              {"ttt" => 4.88}
                          ])

burger = Burger.new(bun, meat, vegetable)
burger.display_burger_info