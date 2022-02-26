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

game = Game.create!(name: "Never Have I Ever", image: "assets/party.jpg")

puts "Creating the other games..."

Game.create!(name: "Picture Me", image: "assets/splash.png")
Game.create!(name: "Oukami", image: "assets/wolf.jpg")
Game.create!(name: "Fill the Blank!", image: "assets/human.jpg")
Game.create!(name: "Spank the Bank!", image: "assets/bank.jpg")

puts "Game creation Complete!"


# Create Contents for Never Have I ever
puts "Creating contents for 'Never Have I Ever'..."

sentences = CreateGameContentsSeeds.generate_sentences
sentences.each { |sentence| GameContent.create!(content: sentence, game_id: game.id) }

puts "Contents for the game have been created!"
