# Require other files
require_relative '../db/seeds/users_seeds'
require_relative '../db/seeds/game_contents_seeds'

# Destroy previous seeds
puts "Deleting previous seeds..."

GameContent.destroy_all
Game.destroy_all
User.destroy_all

puts "Previous seeds have been deleted!"


# Create Users seeds
puts "Creating users..."

CreateUsersSeeds.generate_users

puts "Users have been created!"


# Create Game Never Have I ever
puts "Creating the game 'Never Have I Ever'..."

game = Game.create!(name: "Never Have I Ever")

puts "Game created!"


# Create Contents for Never Have I ever
puts "Creating contents for 'Never Have I Ever'..."

sentences = CreateGameContentsSeeds.generate_sentences
sentences.each { |sentence| GameContent.create!(content: sentence, game_id: game.id) }

puts "Contents for the game have been created!"
