# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

# populate ingredients
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

ingredients = JSON.parse(open(url).read)
ingredients["drinks"].each do |ingredient|
  i = Ingredient.create(name: ingredient["strIngredient1"])
  puts "creating an ingredient #{i.name}"
end

# populate cocktails
cocktails = ["Mojito", "Moscow Mule", "Long Island Iced Tea"]

cocktails.each do |cocktail|
  c = Cocktail.create(name: cocktail)
  puts "created a cocktail #{c.name}"

  Dose.create(description: "#{1 + rand(25)}ml", cocktail_id: c.id, ingredient_id: (1 + rand(Ingredient.count)))
  Dose.create(description: "#{1 + rand(25)}ml", cocktail_id: c.id, ingredient_id: (1 + rand(Ingredient.count)))
  Dose.create(description: "#{1 + rand(25)}ml", cocktail_id: c.id, ingredient_id: (1 + rand(Ingredient.count)))
end