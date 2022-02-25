# Require other files
require_relative '../db/seeds/users_seeds'
require_relative '../db/seeds/game_contents_seeds'

# Destroy previous seeds
puts "Deleting previous seeds..."

PlayerInput.destroy_all
Round.destroy_all
GameContent.destroy_all
Game.destroy_all
Player.destroy_all
Instance.destroy_all
User.destroy_all

puts "Previous seeds have been deleted!"


# Create Users seeds
puts "Creating users..."

CreateUsersSeeds.generate_users

puts "Users have been created!"


# Create Game Never Have I ever
puts "Creating the game 'Never Have I Ever'..."

game = Game.create!(name: "Never Have I Ever")

puts "Creating the other games..."

games = ["Picture Me", "Oukami", "Cards Against Humanity", "Spank the Bank"]

games.each do |game_name|
  Game.create!( name: game_name )
  puts "#{game_name} created!"
end

puts "Game creation Complete!"


# Create Contents for Never Have I ever
puts "Creating contents for 'Never Have I Ever'..."

sentences = CreateGameContentsSeeds.generate_sentences
sentences.each { |sentence| GameContent.create!(content: sentence, game_id: game.id) }

puts "Contents for the game have been created!"
