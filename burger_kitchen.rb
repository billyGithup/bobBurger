require './bun'
require './meat'
require './vegetable'
require './burger'

class BurgerKitchen
  attr_reader :bun_data_file, :meat_data_file, :vegetable_data_file,
              :bun_array, :meat_array, :vegetable_array

  def initialize(bun_data_file, meat_data_file, vegetable_data_file)
    @bun_array = []
    @meat_array = []
    @vegetable_array = []

    self.load_bun_data(bun_data_file)
    self.load_meat_data(meat_data_file)
    self.load_vegetable_data(vegetable_data_file)
  end

  def load_bun_data(file_name)
    raise "Make sure the bun file name ends with .txt!" unless file_name[-4..-1] == ".txt"
    @bun_data_file = file_name

    #Loop through the file and process the data.
    File.readlines(file_name).each do |line|
      arr1 = line.split(" ")
      arr2 = arr1.slice!(1, 1)
      @bun_array << (arr1.zip(arr2).to_h)
    end
  end

  def load_meat_data(file_name)
    raise "Make sure the meat file name ends with .txt!" unless file_name[-4..-1] == ".txt"
    @meat_data_file = file_name

    File.readlines(file_name).each do |line|
      arr1 = line.split(" ")
      arr2 = arr1.slice!(1, 1)
      @meat_array << (arr1.zip(arr2).to_h)
    end
  end

  def load_vegetable_data(file_name)
    raise "Make sure the vegetable file name ends with .txt!" unless file_name[-4..-1] == ".txt"
    @vegetable_data_file = file_name

    File.readlines(file_name).each do |line|
      arr1 = line.split(" ")
      arr2 = arr1.slice!(1, 1)
      @vegetable_array << (arr1.zip(arr2).to_h)
    end
  end

  def order_burger
    bun_choice = choose_bun
    puts
    meat_choice = choose_meat
    puts
    vegetable_choice_list = choose_vegetable
    puts

    bun_name = ""
    bun_price = 0
    meat_type = ""
    meat_price = 0

    bun_array[bun_choice].each do |name, price|
      bun_name = name
      bun_price = price.to_f
    end
    meat_array[meat_choice].each do |name, price|
      meat_type = name
      meat_price = price.to_f
    end

    Burger.new(Bun.new(bun_name, bun_price),
               Meat.new(meat_type, meat_price),
               Vegetable.new(vegetable_choice_list))
  end

  private
  def choose_bun
    bun_count = 0
    item_exist = false

    puts "Here is the menu for the buns. Please choose one."
    bun_array.each do |hash|
      hash.each do |bun, price|
        puts "#{bun_count += 1}) #{bun} - $#{price}"
      end
    end
    print "Your bun choice: "
    choice = gets.chomp.to_i

    until item_exist
      bun_array.each_index do |index|
        if index == (choice - 1)
          item_exist = true
          break
        end
      end

      if !item_exist
        print "Please choose one of the numbers on the menu: "
        choice = gets.chomp.to_i
      end
    end
    choice -= 1
  end

  def choose_meat
    meat_count = 0
    item_exist = false

    puts "Here is the menu for the meat. Please choose one."
    meat_array.each do |hash|
      hash.each do |meat, price|
        puts "#{meat_count += 1}) #{meat} - $#{price}"
      end
    end
    print "Your meat choice: "
    choice = gets.chomp.to_i

    until item_exist
      meat_array.each_index do |index|
        if index == (choice - 1)
          item_exist = true
          break
        end
      end

      if !item_exist
        print "Please choose one of the numbers on the menu: "
        choice = gets.chomp.to_i
      end
    end
    choice -= 1
  end

  def choose_vegetable
    vegetable_count = 0
    correct_list = []
    bool = false

    puts "Here is the menu for the vegetable. You can choose more than one."
    vegetable_array.each do |hash|
      hash.each do |vegetable, price|
        puts "#{vegetable_count += 1}) #{vegetable} - $#{price}"
      end
    end
    print "Your vegetables choice: "
    choice = gets.chomp

    #Validate a list of choice(s).
    until bool
      choice.delete!(" ") if choice.include?(" ") #Delete all whitespaces in the input if there is any.
      if choice !~ /\D/ and !choice.include?("0") #Check if choice contains only integer(s) and has no 0 number.
        choice = choice.split("").map(&:to_i).uniq #Convert the choice into an array of integer value(s) with no duplicates.
        bool = indexes_exist?(vegetable_array, choice)
      end

      if !bool
        print "Please only choose one of the numbers on the menu: "
        choice = gets.chomp
      end
    end
    item_sets = get_items(choice)
  end

  #Check if the value(s) in the choice array exist in the vegetable_array.
  def indexes_exist?(vegie_arr, choice_arr)
    vegie_index = []
    vegie_arr.each_index {|index| vegie_index << index}
    if choice_arr.length > vegie_arr.length
      return false
    else
      choice_arr.each do |value|
        return false if !vegie_index.include?(value - 1)
      end
    end
    true
  end

  #Find correct item pair based on indexes and return them.
  def get_items(array)
    item_sets = []
    control_index = []
    vegetable_array.each_index { |index| control_index << index }
    array.each do |value|
      item_sets << vegetable_array[value - 1] if control_index.include?(value - 1)
    end
    item_sets
  end
end