require './player.rb'

class Simulator

	def initialize(human_player, computer_player)
		@human = human_player
		@computer = computer_player
	end

	def evaluate_move(move)
		@computer.add_square(move)
		@player.lose_square(move)

		opponent_moves = all_human_moves_to_consider
		opponent_moves.each do |opp_move|
			return "bad" if two_way_win(opp_move)
			if computer_constrained?(opp_move)
				return evaluate_move(constrained_computer_move)
			else
				return "good"
			end
		end
	end


end