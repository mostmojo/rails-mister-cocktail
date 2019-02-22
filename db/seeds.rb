# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'faker'

# populate ingredients
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients = JSON.parse(open(url).read)

ingredients["drinks"].each do |ingredient|
  i = Ingredient.create(name: ingredient["strIngredient1"])
  puts "creating an ingredient #{i.name}"
end

# populate cocktails
cocktails = Array.new(50) { Faker::Zelda.character }

cocktails.each do |cocktail|
  c = Cocktail.create(name: cocktail)
  puts "created a cocktail #{c.name}"
end

# create some doses for each cocktails
Cocktail.all.each do |cocktail|
  # get all the ingredient ids that are available (we'll need this later)
  ingredient_ids = Ingredient.pluck(:id)
  # pick a random number of ingredients between 2-5
  number_of_ingredients = rand(3) + 2
  # add that many doses
  number_of_ingredients.times do    
    # add a random measurement, also assign the cocktail and a random ingredient
    Dose.create(description: Faker::Measurement.metric_volume, cocktail: cocktail, ingredient: Ingredient.find(ingredient_ids.sample))
    puts "added a dose to #{cocktail.name}"
  end
end