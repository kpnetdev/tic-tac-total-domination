require './player.rb'

class Simulator

	def initialize(human_player, computer_player, move, prev_level_player_move=nil)
		@player = human_player.make_copy
		@computer = computer_player.make_copy
		@move = move
		@prev_level_player_move = prev_level_player_move
	end

	def evaluate
		computer_play_move!
		player_play_move!(@prev_level_player_move) if @prev_level_player_move
		player_moves = all_player_moves_to_consider
		player_moves.each do |player_move|
			player_move_sim = Simulator.new(@player, @computer, player_move)
			ways_you_can_die = player_move_sim.find_checkmate_squares
			return "bad" if ways_you_can_die.count > 1
			if ways_you_can_die.count == 1
				result = Simulator.new(@player, @computer, ways_you_can_die.first, player_move).evaluate
				return result if result == "bad"
			end
		end
		return "good"
	end

	def computer_play_move!
		@computer.add_square(@move)
		@player.lose_square(@move)
	end

	def player_play_move!(prev_level_move=nil)
		move = prev_level_move || @move
		@player.add_square(move)
		@computer.lose_square(move)
	end

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
	
	def find_checkmate_squares
		player_play_move!
		@computer.all_one_move_wins(@move)
	end
end
