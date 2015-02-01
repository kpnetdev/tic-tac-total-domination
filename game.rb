require './board.rb'
require './simulator.rb'
require 'pry'

class Game

	def initialize
		# @board = Board.new
		@computer = Player.new("Computer", "Y")
		@player = Player.new("Human", "X")
		@players = [@computer, @player]
	end

	def start!
		@board.draw!
		until we_have_a_loser || @board.full?
			square = get_player_move
			player_move!(square)
			@board.update!(@computer, @player)
			computer_move! unless @board.full?
			@board.update!(@computer, @player)
			@board.draw!
		end
	end

	def we_have_a_loser
		@players.select {|player| player.lost?}.first
	end

	def get_player_move
		loop do
			square = gets.chomp.to_i
			break square if valid_square?(square)
			puts "invalid choice"
		end
	end

	def valid_square?(square)
		!taken_squares.include?(square) && (1..9).to_a.include?(square)
	end

	def taken_squares
		@players.map {|player| player.squares}.flatten
	end		

	def player_move!(square)
		@player.add_square(square)
		@computer.lose_square(square)
	end

	def computer_move!(square)
		# square = unbeatable_move
		@computer.add_square(square)
		@player.lose_square(square)
	end

	def unbeatable_move
		winning_move = @player.all_one_move_wins.first
		return winning_move if winning_move

		self_defense = (@computer.all_one_move_wins - @computer.squares).first
		return self_defense if self_defense

		open_squares.each do |square|
			return square if evaluate_move(square) == "good"
		end
	end

	def open_squares
		(1..9).to_a - taken_squares 
	end

	def evaluate_move(move)
		Simulator.new(@player, @computer, move).evaluate
	end

	def import!(board_array)
		board_array.each_with_index do |letter, index|
			if letter == "X"
				player_move!(index)
			elsif letter == "O"
				computer_move!(index)
			end
		end
	end

	def square_id_for_computer_move
		"#s#{unbeatable_move}"
	end

	def self.get_computer_move(board_array)
		game = Game.new
		game.import!(board_array)
		game.square_id_for_computer_move
	end
end


# game = Game.new
# game.start!