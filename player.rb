class Player
	attr_accessor :name, :winning_combos, :squares, :letter

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
		@winning_combos.select {|combo| combo.empty?}.first
	end

	def vulnerable_combos
		@winning_combos.select {|combo| combo.length == 2}
	end

	def vulnerable_squares
		freq_hash = vulnerable_combos.flatten.inject(Hash.new(0)) do |hsh, num|
			hsh[num] += 1
			hsh
		end
		freq_hash.keys.select {|k| freq_hash[k] > 1 }
	end

	def all_one_move_wins(player_move=nil)
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

	private

	def get_winning_combos
		horizontals = [[1,2,3],[4,5,6],[7,8,9]]
		verticals = horizontals.transpose
		diagonals = [[1,5,9],[3,5,7]]
		winning_combos = horizontals + verticals + diagonals
	end
end
