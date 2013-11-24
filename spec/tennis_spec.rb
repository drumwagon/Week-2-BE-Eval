require 'rubygems'
require 'bundler/setup'
require 'rspec'
require_relative '../tennis'

describe Tennis::Game do
  let(:game) { Tennis::Game.new }
  
  describe '.initialize' do
    it 'creates two players' do
      expect(game.player1).to be_a(Tennis::Player)
      expect(game.player2).to be_a(Tennis::Player)
    end

    it 'sets the opponent for each player' do
      expect(game.player1.opponent).to eq(game.player2)
      expect(game.player2.opponent).to eq(game.player1)
    end
  end

  describe '#wins_ball' do
    it 'increments the points of the winning player' do
      game.wins_ball(game.player1)

      expect(game.player1.points).to eq(1)
    end
  end
end

describe Tennis::Player do
  let(:player) do
    player = Tennis::Player.new
    player.opponent = Tennis::Player.new

    return player
  end

  describe '.initialize' do
    it 'sets the points to 0' do
      expect(player.points).to eq(0)
    end 
  end

  describe '#record_won_ball!' do
    it 'increments the points' do
      player.record_won_ball!

      expect(player.points).to eq(1)
    end
  end

  describe '#score' do
    context 'when points is 0' do
      it 'returns love' do
        expect(player.score).to eq('love')
      end
    end
    
    context 'when points is 1' do
      it 'returns fifteen' do
        player.points = 1

        expect(player.score).to eq('fifteen')
      end 
    end
    
    context 'when points is 2' do
      it 'returns thirty' do 
        player.points = 2

        expect(player.score).to eq('thirty')
      end
    end
    
    context 'when points is 3' do
      it 'returns forty' do
        player.points = 3

        expect(player.score).to eq('forty')
      end
    end

    context 'when points are 3 or greater' do
      context 'and player scores are even' do
        it 'returns deuce' do 
          player.points = 4
          player.opponent.points = 4

          expect(player.score).to eq('deuce')
        end
      end
      
      context 'and one player has one more point than the other' do
        it "returns ad opponent" do
          # I really want "returns ad #{leading player}" at any point condition.
          player.points = 4
          player.opponent.points = 5 

          expect(player.score).to eq("ad opponent")
        end
        it "returns ad player1" do
          # I really want "returns ad #{leading player}" at any point condition.
          player.points = 6
          player.opponent.points = 5 

          expect(player.score).to eq("ad player1")
        end
      end
    end
    context 'When points are 4 or higher and one player has two more points than the other' do
      it "returns player1 wins" do 
        player.points = 7
        player.opponent.points = 5 

        expect(player.score).to eq("player1 wins!")
      end
      it "returns opponent wins" do 
        player.points = 3
        player.opponent.points = 5 

        expect(player.score).to eq("opponent wins!")
      end
    end
  end
end











