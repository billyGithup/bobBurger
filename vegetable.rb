class Vegetable
  attr_reader :vegetable_list

  def initialize(hash_list)
    begin
      hash_list.each do |hash|
        hash.each do |name, price|
          raise "One of the vegetable names is missing." if name.empty?
          raise "One of the vegetable price tags is not correct." if price.to_f == 0 or price.to_f < 0
        end
      end
    rescue => e
      puts e
      exit
    end
    @vegetable_list = hash_list
  end

  def get_total_price
    total = 0
    self.vegetable_list.each do |hash|
      hash.each do |name, price|
        total += price.to_f
      end
    end
    total
  end

  def get_all_names
    vegetable_names = ""
    self.vegetable_list.each do |hash|
      hash.each do |name, price|
        vegetable_names += "#{name}, "
      end
    end
    vegetable_names[-2, 2] = ""
    vegetable_names
  end

  def display_vegetable_info
    self.vegetable_list.each do |hash|
      hash.each do |name, price|
        puts "#{name} - $#{price}"
      end
    end
  end
end