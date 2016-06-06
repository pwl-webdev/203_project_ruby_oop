class Player
	attr_accessor :symbol, :move
	def initialize(symbol, move=true)
		@symbol = symbol
		@move = move
	end
end