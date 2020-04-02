class Meat
  attr_reader :name, :price

  def initialize(name, price)
    begin
      raise "Meat name is empty!" if name.empty?
      raise "Meat price cannot be or less than zero!" if price == 0 or price < 0
    rescue => e
      puts e
      exit
    end
    @name = name
    @price = price
  end

  def display_meat_info
    puts "Meat: #{name} - $#{price}"
  end
end