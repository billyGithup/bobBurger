require './burger_kitchen'

puts "=" * 34 + "\n||\t\t\t\t||\n||\t    BOB BURGER\t\t||\n||\t\t\t\t||\n" + "=" * 34
print "Welcome to Bob Burger shop! Would you like to make an order Y/N? "
answer = gets.chomp.downcase

until answer == "y" or answer == "n"
  print "Please enter letter \"y\" or letter \"n\": "
  answer = gets.chomp.downcase
end
puts "Thank you for coming, bye!" if answer == "n"

# answer = "y"
while answer == "y"
  burger_kitchen = BurgerKitchen.new("buns.txt", "meats.txt", "vegetable.txt")
  burger = burger_kitchen.order_burger
  burger.display_burger_info
  puts "Your total price is $%.2f" % (burger.bun.price + burger.meat.price + burger.vegetable.get_total_price).to_s
  puts

  print "Would you like to order another burger Y/N? "
  answer = gets.chomp.downcase
  puts "Thank you! Please come again. :)" if answer == "n"
end