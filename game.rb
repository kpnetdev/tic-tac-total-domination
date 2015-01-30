require './player.rb'
require './board.rb'
require 'pry'

class Game
	attr_accessor :players ## REMOVE!! JUST FOR TESTING!! ##

	def initialize
		@board = Board.new
		@players = make_players!
	end

	def start!
		@board.draw!

		until we_have_a_loser || @board.full?
			current_player, other_player = @players.reverse!
			square = get_move
			current_player.add_square(square)
			other_player.lose_square(square)
			@board.update!(current_player, square)
			@board.draw!
		end
	end


	def get_move
		loop do
			square = gets.chomp.to_i
			break square if valid_square?(square)
			puts "invalid choice"
		end
	end

	def valid_square?(square)
		taken_squares = @players.map {|player| player.squares}.flatten
		!taken_squares.include?(square) && (1..9).to_a.include?(square)
	end


	def game_won?
		@players.map {|player| player.squares}.flatten.include?(13)
	end

	def we_have_a_loser
		@players.select {|player| player.lost?}.first
	end

	# def analyze_board
	# 	# test_game = self.dup

	# 	human, computer = @players.partition {|player| player.name == "Human"}
	# 	[[human_squares, human_combos], [computer_squares, computer_combos] = [human, computer].map do |player|






	# end



	private

	def make_players!
		[Player.new("Computer", "Y"), Player.new("Human", "X")]
	end


end


game = Game.new
game.start!