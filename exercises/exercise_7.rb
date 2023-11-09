require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'
require_relative './exercise_6'

puts "Exercise 7"
puts "----------"

# Your code goes here ...

### Exercise 7: Validations for both models

# 1. Add validations to two models to enforce the following business rules:

# [x] Employees must always have a first name present
# [x] Employees must always have a last name present
# [x] Employees have a hourly_rate that is a number (integer) between 40 and 200
# [x] Employees must always have a store that they belong to (can't have an employee that is not assigned a store)
# [x] Stores must always have a name that is a minimum of 3 characters
# [x] Stores have an annual_revenue that is a number (integer) that must be 0 or more
# [x] BONUS: Stores must carry at least one of the men's or women's apparel (hint: use a [custom validation method](http://guides.rubyonrails.org/active_record_validations.html#custom-methods) - **don't** use a `Validator` class)

# 2. Ask the user for a store name (store it in a variable)
# 3. Attempt to create a store with the inputted name but leave out the other fields (annual_revenue, mens_apparel, and womens_apparel)
# 4. Display the error messages provided back from ActiveRecord to the user (one on each line) after you attempt to save/create the record


class Employee < ActiveRecord::Base
  validates :first_name, :last_name, :store, :hourly_rate, presence: true
  validates :hourly_rate, numericality: { only_integer: true, greater_than_or_equal_to: 40, less_than_or_equal_to: 200 }
  
end

class Store < ActiveRecord::Base
  validates :name, length: { minimum: 3 }
  validates :annual_revenue, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  validate :carry_at_least_one_mens_or_womens

  def carry_at_least_one_mens_or_womens
    if mens_apparel.nil? && womens_apparel === false 
      errors.add(:mens_apparel, "is empty and women was set to false. Stores must carry at least one of the men's or women's apparel")
    elsif mens_apparel === false && womens_apparel.nil? 
      errors.add(:womens_apparel, "is empty and men was set to false. Stores must carry at least one of the men's or women's apparel")
    elsif mens_apparel === false && womens_apparel === false
      errors.add(:carry_at_least_one_mens_or_womens, ". Stores must carry at least one of the men's or women's apparel. Both mens and womens were set to false")
    elsif mens_apparel.nil? && womens_apparel.nil?
      errors.add(:carry_at_least_one_mens_or_womens, ". Stores must carry at least one of the men's or women's apparel. Both mens and womens were not provided")
    end
  end
end

#this should work
@store1.employees.create(first_name: "New", last_name: "Empl", hourly_rate: 60)

#this should not work
@store1.employees.create(last_name: "NoFirstNamed", hourly_rate: 60)

#this should not work either
@store1.employees.create(first_name: "String", last_name: "Hourly Rate", hourly_rate: "abc")

#this should not work
@store1.employees.create(first_name: "String", last_name: "Hourly Rate", hourly_rate: 30)

#this should work
Store.create(name: "LongName", annual_revenue: 2, mens_apparel:true)
Store.create(name: "LgN", annual_revenue:10002, womens_apparel:true)

#this should not work
Store.create(name: "Lo")
Store.create(name: "L")

#this should work
Store.create(name: "Winnipeg", annual_revenue: 1, mens_apparel:true)
Store.create(name: "Kelowna", annual_revenue: 0, womens_apparel:true)

#this should not work
Store.create(name: "No apparel", annual_revenue: 1)
Store.create(name: "No apparel 2", annual_revenue: 0)

#this should not work
Store.create(name: "Surrey", annual_revenue: "ghj")

#this should work
Store.create(name: "Mens true", annual_revenue: "5", mens_apparel:true)
Store.create(name: "Womens true", annual_revenue: "5", womens_apparel:true)
Store.create(name: "Both true", annual_revenue: "5", mens_apparel:true, womens_apparel:true)
Store.create(name: "Mens true, Womens false", annual_revenue: "5", mens_apparel:true, womens_apparel:false)
Store.create(name: "Womens true, mens false", annual_revenue: "5", mens_apparel:false, womens_apparel:true)


#this should not work
Store.create(name: "Mens false", annual_revenue: "5", mens_apparel:false)
Store.create(name: "Womens false", annual_revenue: "5", womens_apparel:false)
Store.create(name: "Both false", annual_revenue: "5", mens_apparel:false, womens_apparel:false)


print "Enter Store name: "
name1 = gets.chomp.to_s
@store_created = Store.create(name: name1)
if @store_created.valid? === false
  puts "There are some errors: "
   @store_created.errors.full_messages.each do |error|
      pp error
    end
end




