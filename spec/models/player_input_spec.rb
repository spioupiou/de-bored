require 'rails_helper'

RSpec.describe PlayerInput, type: :model do
  let(:user) { User.create(username: "Luffy", nickname: "Luffy", password: "123456") }
  let(:game) { Game.create(name: 'Have You Ever?') }
  let(:instance) { Instance.create(game: game, user: user, passcode: "randompasscode") }
  let(:player) { Player.create(user: user, instance: instance) }
  let(:round) { Round.create(number: 1)}

  let(:player_input) { PlayerInput.new(player: player, instance: instance, input_value: "Yes", round_id: round.id) }

  describe '#initialize' do
    context 'when valid' do
      it 'generates a valid player_input with all necessary fields' do
        expect(player_input.valid?).to eq(true)
      end
    end

    # Player_input must belong to a user
    context 'when invalid' do
      context 'no player' do
        before { player_input.player = nil }

        it 'generates an invalid player_input' do
          expect(player_input.valid?).to eq(false)
        end

        it 'generates an error message' do
          player_input.valid?
          # Player_id must be present / must reference foreign key 'user'
          expect(player_input.errors.messages).to eq({:player=>["must exist"], :player_id=>["can't be blank"]})
        end
      end

      # User can only answer once every round
      context 'identical round' do
        # Create a Player Input with same player_id/round_id combination
        before { PlayerInput.create(player: player, instance: instance, input_value: "No", round_id: round.id) }
        # The player_input that is being tested then becomes invalid
        it 'is invalid if the combination round_id/player_id already exists' do
          expect(player_input).to be_invalid
        end
      end
    end
  end
end
