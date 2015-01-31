require './player.rb'

class ComboAnalyzer
	attr_reader :player, :computer

	def initialize(human_player, computer_player)
		@player = human_player
		@computer = computer_player
	end

	def humanmove(num)
		@player.add_square(num)
		@computer.lose_square(num)
		# printout
	end

	def computermove(num)
		@computer.add_square(num)
		@player.lose_square(num)
		# printout
	end

	def printout
		puts "Player Squares:  #{@player.squares}"
		puts "Player Combos:   #{@player.winning_combos}"
		puts
		puts "Computer Squares:  #{@computer.squares}"
		puts "Computer Combos:   #{@computer.winning_combos}"
	end

	def scenario_one
		humanmove 1
		computermove 5
		humanmove 9
		puts "DECISION SITUATION: good: 2,4,6,8;   bad: 3,7"
		printout
		# puts; puts "choose 3 -- lose"
		# computermove 3
		# printout
	end

	def analysis
		if constrained_move
			puts "Take square #{constrained_move}"
		else
			weakpoints = @computer.vulnerable_squares
			if weakpoints.count == 0
				puts "Whatever"
			elsif weakpoints.count == 1
				puts "Take square #{weakpoints.first}"
			else
				puts "Take square #{misdirection_square}"
			end
		end
	end

	def constrained_move
		must_take_array = @computer.winning_combos.select do |combo|
			combo.length == 1 && !@computer.squares.include?(combo.first)
		end
		must_take_array.first.first if !must_take_array.empty?
	end



	def misdirection_square
		player_combo_weakpoints = @player.vulnerable_combos
		available_combo_weakpoints = player_combo_weakpoints.reject do |combo|
			(combo & @player.squares).first
		end
		safe_combo_weakpoints = available_combo_weakpoints.reject do |combo|
			(combo & @computer.vulnerable_squares).count > 1
		end
		safe_combo_weakpoints.first.first
	end

	##call evaluate_move from outside with (move, @player.make_copy, @computer.make_copy)##

	def evaluate_move(move, player, computer)
		opponent_moves = all_human_moves_to_consider(player)
		opponent_moves.each do |opp_move|
			return "bad" if two_way_win(opp_move)
			if computer_constrained?(opp_move)
		



end