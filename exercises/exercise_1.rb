require_relative '../setup'

puts "Exercise 1"
puts "----------"
### Exercise 1: Create 3 stores

# 1. Use Active Record's `create` class method multiple times to create 3 stores in the database:

# - Burnaby (annual_revenue of 300000, carries men's and women's apparel)
# - Richmond (annual_revenue of 1260000 carries women's apparel only)
# - Gastown (annual_revenue of 190000 carries men's apparel only)

# 2. Output (`puts`) the number of the stores using ActiveRecord's `count` method, to ensure that there are three stores in the database.


# Your code goes below here ...

burnaby_store = Store.create(name: "Burnaby", annual_revenue: 300000, mens_apparel: true, womens_apparel: true)
burnaby_store.save

richmond_store = Store.create(name: "Richmond", annual_revenue: 1260000, mens_apparel: false, womens_apparel: true)
richmond_store.save

gastown_store = Store.create(name: "Gastown", annual_revenue: 190000, mens_apparel: true, womens_apparel: false)
gastown_store.save

puts "Number of stores in database: #{Store.count}"
