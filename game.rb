# require './player.rb'
require './board.rb'
require './simulator.rb'
# require 'pry'

class Game
	attr_accessor :players ## REMOVE!! JUST FOR TESTING!! ##

	def initialize
		@board = Board.new
		@computer = Player.new("Computer", "Y")
		@player = Player.new("Human", "X")
		@players = [@computer, @player]
	end

	def start!
		@board.draw!

		until we_have_a_loser || @board.full?
			# current_player, other_player = @players.reverse!
			square = get_player_move
			binding.pry
			player_move!(square)
			# current_player.add_square(square)
			# other_player.lose_square(square)
			computer_move!
			binding.pry
			@board.update!(@computer, @player)
			@board.draw!
		end
	end

	def player_move!(square)
		@player.add_square(square)
		@computer.lose_square(square)
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


	# def game_won?
	# 	@players.map {|player| player.squares}.flatten.include?(13)
	# end

	def we_have_a_loser
		@players.select {|player| player.lost?}.first
	end

	def computer_move!
		square = unbeatable_move
		@computer.add_square(square)
		@player.lose_square(square)
	end

	def unbeatable_move
		no_brainer = @player.all_one_move_wins.first
		return no_brainer if no_brainer
		open_squares.each do |square|
			return square if evaluate_move(square) == "good"
			# binding.pry
		end
	end

	def taken_squares
		@players.map {|player| player.squares}.flatten
	end		

	def open_squares
		(1..9).to_a - taken_squares 
	end

	def evaluate_move(move)
		Simulator.new(@player, @computer, move).evaluate

		# @computer.add_square(move)
		# @player.lose_square(move)

		# opponent_moves = all_player_moves_to_consider
		# opponent_moves.each do |opp_move|
		# 	return "bad" if two_way_win(opp_move)
		# 	if computer_constrained?(opp_move)
		# 		return evaluate_move(constrained_computer_move)
		# 	else
		# 		return "good"
		# 	end
		# end
	end


	private

	def make_players!
		[Player.new("Computer", "Y"), Player.new("Human", "X")]
	end

end


game = Game.new
game.start!