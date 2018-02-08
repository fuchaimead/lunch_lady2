# require_relative 'wallet'
require_relative 'person'

class Lunchroom
  def initialize  
    @main = [
    {name: "spaghetti", price: 8.99}, 
    {name: "chicken nuggets", price: 5.99},
    {name: "cheesesteak", price: 10.54},
    {name: "pasta salad", price: 3.99}, 
    {name: "sushi", price: 9.99}]
    
    @sides = [
      {name: "pudding", price: 1.75},
      {name: "fries", price: 3.99},
      {name: "salad", price: 3.99},
      {name: "fruit bowl", price: 2.50},
      {name: "pie", price: 2.25}
    ]
    
    @drinks = [
      {name: "water", price: 0},
      {name: "soda", price: 1.50},
      {name: "juice", price: 2.25},
      {name: "coffee", price: 1.50},
      {name: "tea", price: 1.50}
    ]
    
    puts "Welcome to the Lunch Room."
    puts "What is your name?"
    name = gets.strip
    puts "How much money do you have?"
    wallet = gets.strip.to_i
    items = []
    @buyer = Person.new(name, wallet, items)
    puts "#{@buyer.name} you have $#{@buyer.wallet} for lunch."
    running_order
  end

  def menu 
    puts "1) Place new order"
    puts "2) Edit Order"
    puts "3) Exit"
    option = gets.strip.to_i 
    case option 
      when 1
        initialize 
      when 2
        edit 
      when 3
        exit 
      else 
        puts "Not valid option."
        menu
    end 
  end 

  def edit_order
    
  end 

  def running_order 
    main
    sides
    drinks
    order
  end

  def item_list(food)
  food.each_with_index do |item, i| 
    puts "#{i + 1}) #{item[:name]} $#{item[:price]}"
  end
end

def main
  puts "-------------"
  puts "What main dish would you like?"
  item_list(@main)
    main_order = gets.strip.to_i
    if main_order >= 1 && main_order <=5
    main_dish = @main[main_order - 1]
    @buyer.items << main_dish
    puts "You ordered #{main_dish[:name]}."
    else 
      puts "Sorry that's not an option."
      running_order
    end
  end

  def sides
    puts "You get two sides. Please choose 2:"
    while @buyer.items.length < 3
      item_list(@main)
      user_input = gets.to_i
      @buyer.items << @sides[user_input -1]
    end
  end

  
  def drinks
    puts "What drink would you like?"
    item_list(@drinks)
    drink_order = gets.strip.to_i
    if @drinks[drink_order]                
    drink = @drinks[drink_order - 1]
    @buyer.items << drink
    puts "You ordered #{drink[:name]}."
  else 
    puts "Sorry that's not an option."
    running_order
  end
  end

  def order
    puts " ---------------"
    puts "Your final order contains: "
    @buyer.items.each do | dish | 
      print "#{dish[:name]}, "
    end
    total
  end 

  def total 
    total = []
    @buyer.items.each do | cost |
      total << cost[:price]
    end
    sum = total.reduce(&:+)
    remaining = @buyer.wallet - sum  
    if @buyer.wallet < sum 
    puts "You can't afford that much food!"
    running_order
    else
      puts ""
      puts "Your total is $#{sum}."
      puts "Your wallet has $#{'%.2f' % remaining} remaining."
    end 
    menu
  end
end

Lunchroom.new


