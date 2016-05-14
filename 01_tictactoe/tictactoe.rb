class TicTacToe
	require_relative 'board.rb'
	require_relative 'player.rb'

	def initialize ()
		@input = nil
		@player1 = nil
		@player2 = nil
		@board = Board.new()
		@victory = false
	end

	def gameSetup
		puts "Start TicTacToe game"
		puts "Exit by typing 'quit'"
		while @input != "quit" do
			puts "select symbol x or o for player1"
			@input = gets.chomp()
			if @input.downcase == "x"
				@player1 = Player.new("x",true)
				@player2 = Player.new("o", false)
				break
			elsif @input.downcase == "o"
				@player1 = Player.new("o", true)
				@player2 = Player.new("x", false)
				break
			end
		end
		return @input
	end

	def gameLoop
		@board.display
		while !@victory do
			if @player1.move
				if @board.performMove(@player1)
					@player1.move = false
					@player2.move = true
				end
			elsif @player2.move
				if @board.performMove(@player2)
					@player1.move = true
					@player2.move = false
				end
			end
			@board.display
			if @board.victory?
				@victory = true
			end
		end
	end

	def gameReset
		@board.reset
	end
end