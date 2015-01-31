require './player.rb'
require 'pry'

class Simulator

	def initialize(human_player, computer_player, move, test_only=nil)
		@player = human_player.make_copy
		@computer = computer_player.make_copy
		@move = move
		@test_only = test_only
	end

	def evaluate
		computer_play_move!
		player_moves = all_player_moves_to_consider
		player_moves.each do |player_move|
			player_move_sim = Simulator.new(@player, @computer, player_move, @computer)
			binding.pry ## 1-level deep @computer copy with square - correct
			ways_you_can_die = player_move_sim.find_checkmate_squares
			binding.pry  ## 1-level deep @computer copy without square --- SWEET JESUS, WHY?!
			return "bad" if ways_you_can_die.count > 1
			if ways_you_can_die == 1
				return Simulator.new(@player, @computer, ways_you_can_die.first).evaluate
			else
				return "good"
			end
		end
	end

	def computer_play_move!
		@computer.add_square(@move)
		# binding.pry
		@player.lose_square(@move)
		# binding.pry
	end

	def player_play_move!
		@player.add_square(@move)
		# binding.pry
		@computer.lose_square(@move)
		# binding.pry
	end

	def find_checkmate_squares
		binding.pry ## 2-level deep @computer copy with square - correct
		player_play_move!
		binding.pry ## 2-level deep @computer copy without square - correct
		@computer.all_one_move_wins(@move)
		# binding.pry
	end

	# def two_way_win?
	# 	player_play_move!
	# 	@computer.all_one_move_wins.count > 1
	# end

	# def computer_constrained?
	# 	@computer.all_one_move_wins.count == 1
	# end

	def all_player_moves_to_consider
		constrained_moves = @player.all_one_move_wins
		constrained_moves.empty? ? open_squares : constrained_moves
	end

	def taken_squares
		[@player, @computer].map {|player| player.squares}.flatten
	end		

	def open_squares
		(1..9).to_a - taken_squares 
	end


end