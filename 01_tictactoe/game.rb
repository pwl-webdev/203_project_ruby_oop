require_relative 'board.rb'
require_relative 'tictactoe.rb'
require_relative 'player.rb'

playing = true

while playing do
	game = TicTacToe.new()
	if game.gameSetup() == 'quit'
		playing = false
	end
	game.gameLoop()
	game.gameReset()
end