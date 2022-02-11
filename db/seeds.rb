# Require other files
require_relative 'users_seeds'
require_relative 'games_data_seeds'

# Destroy previous seeds
puts "Deleting previous seeds..."

User.destroy_all

puts "Previous seeds have been deleted!"


# Create Users seeds
puts "Creating users..."

CreateUsersSeeds.generate_users

puts "Users have been created!"


# Create Game
puts "Creating the game..."

game = Game.create!(name: "Never Have I Ever")

puts "Game created!"

# Create Game Data
puts "Creating game data..."

sentences = CreateGamesDataSeeds.generate_sentences
sentences.each { |sentence| GamesDatum.create!(content: sentence, game_id: game.id) }
