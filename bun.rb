class Bun
  attr_reader :name, :price

  def initialize(name, price)
    begin
      raise "Bun name is empty!" if name.empty?
      raise "Bun price cannot be or less than zero!" if price == 0 or price < 0
    rescue => e
      puts e
      exit
    end
    @name = name
    @price = price
  end

  def display_bun_info
    puts "Bun: #{name} - $#{price}"
  end
end