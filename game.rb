require './simulator.rb'

class Game

	def initialize
		@computer = Player.new("Computer", "Y")
		@player = Player.new("Human", "X")
		@players = [@computer, @player]
	end

	def taken_squares
		@players.map {|player| player.squares}.flatten
	end		

	def player_move!(square)
		@player.add_square(square)
		@computer.lose_square(square)
	end

	def computer_move!(square)
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
				player_move!(index + 1)
			elsif letter == "O"
				computer_move!(index + 1)
			end
		end
	end

	def computer_move_and_board_status
		"#s#{unbeatable_move}"
	end


	def self.get_computer_move(board_array)
		game = Game.new
		game.import!(board_array)
		game.computer_move_and_board_status
	end
end
