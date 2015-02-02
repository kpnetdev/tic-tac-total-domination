class Player
	attr_reader		:name, :letter
	attr_accessor :winning_combos, :squares

	def initialize(name, letter)
		@name = name
		@letter = letter
		@winning_combos = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]	
		@squares = []
	end

	def add_square(square)
		@squares << square
	end

	def lose_square(square)
		@winning_combos.map! {|combo| combo.reject {|c| c == square}}
	end

	def lost?
		@winning_combos.find {|combo| combo.empty?}
	end

	def killing_blows
		@winning_combos.select {|combo| combo.length == 1}.flatten
	end

	def one_move_losses(player_move=nil)
		@winning_combos.select do |combo|
			test_combo = player_move ? (combo - [player_move]) : combo
			test_combo.count == 1 && !@squares.include?(test_combo.first)
		end.flatten
	end

	def make_copy
		copy = Player.new("#{self.name} - copy", self.letter)
		copy.winning_combos = @winning_combos.dup
		copy.squares = @squares.dup
		return copy
	end
end
