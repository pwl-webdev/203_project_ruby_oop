require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'computerPlayer.rb'

#player = Player.new()
#player.playGame()

#player = ComputerPlayer.new()
#player.playGame()
noSuccess = 0
noFailures = 0

100.times do
	player = ComputerPlayer.new()
	result = player.playGame()
	if result
		noSuccess += 1
	else
		noFailures +=1 
	end
end
puts "No of success #{noSuccess}, No of failures #{noFailures}, Success Ratio: #{noSuccess.to_f/(noSuccess.to_f+noFailures.to_f)}"