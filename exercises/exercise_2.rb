require_relative '../setup'
require_relative './exercise_1'

puts "Exercise 2"
puts "----------"

# Your code goes here ...

# 1. Load the first store (with `id = 1`) from the database and assign it to an instance variable `@store1`.
# 2. Load the second store from the database and assign it to `@store2`.
# 3. Update the first store (`@store1`) instance in the database. (Change its name or something.)

@store1 = Store.find_by(id: 1)
@store2 = Store.find_by(id: 2)
# @store1.name = "Vancouver"
# @store1.save
@store1.update(name: "Vancouver")
puts "Changed store info: "
pp @store1

puts "First element from database for testing purpose"
pp Store.find_by(id: 1)
