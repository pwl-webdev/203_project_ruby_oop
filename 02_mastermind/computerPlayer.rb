require_relative 'board.rb'
require_relative 'player.rb'

class ComputerPlayer < Player
	def initialize
		@guessHistory = {}
		@round = 1
		@guessPrecision = {}
		@board = Board.new()
		@mustStay = []
		@forbidden = []
		@success
	end

	def checkVictory()
		if @round > 12
			puts "!!! End of Game - You Lost !!!"
			puts "Secret Code = "
			@board.displayCode()
			return true
		elsif @guessPrecision[@round - 1][0] == 4
			puts "!!! You won !!!"
			puts "Secret Code = "
			@board.displayCode()
			@success = true
			return true
		else
			return false
		end
	end

	def playGame()
		gameON = true
		while gameON do
			#@board.displayCode
			#oneLiner()
			guess = findNextMove
			makeAGuess(guess)
			#displayHistory()
			gameON = !checkVictory()
			#puts "gameOn "+gameON.to_s
		end
		return @success
	end

	def oneLiner()
		puts "Computer will guess 4 colors in order (use \e[31mR\e[0m \e[32mG\e[0m \e[34mB\e[0m \e[33mY\e[0m \e[36mC\e[0m \e[35mM\e[0m):"
	end

	def findNextMove
		if @guessPrecision[@round-1] == nil
			return randomGuess(4, nil)
			#[match][contains]
		elsif @guessPrecision[@round-1][1] < 4
			notPresent = 4
			lastGuess = nil
			@guessHistory.each_pair do |key, value|
			#	puts "key #{key} value #{value}"
				if @guessPrecision[key][1] >= (4 - notPresent)
					notPresent = 4 - @guessPrecision[key][1]
					lastGuess = @guessHistory[key].clone
				end
				if key >= 2
					if @guessPrecision[key][1] < @guessPrecision[key-1][1]
						#puts "nastąpiło cofnięcie"
						#puts @guessHistory[key-1]
						#puts @guessHistory[key]
						@mustStay << (@guessHistory[key-1].clone - @guessHistory[key].clone)[0]
						@forbidden << (@guessHistory[key].clone - @guessHistory[key-1].clone)[0]
						@mustStay = @mustStay.uniq
						@forbidden = @forbidden.uniq
						#puts "--mustStay: #{@mustStay}   --forbidden #{@forbidden}"
					end 
				end
			end
			
			#puts "---lastGuess---"
			#print lastGuess
			#puts notPresent
			newGuess = randomGuess(notPresent, lastGuess)
			# puts notPresent
			# puts "----newGuess---"
			#puts newGuess
			(notPresent).times do |i|
				rN = Random.new.rand(0..3)
				while @mustStay.include? lastGuess[rN] do
					#puts "must stay triggered"
					rN = Random.new.rand(0..3)
				end
				while lastGuess[rN].include? newGuess[i]
					rN = Random.new.rand(0..3)
				end
				lastGuess[rN] = newGuess[i]
			end
			#puts "---guess to return---"
			#puts lastGuess
			return lastGuess
		else
		# dzięki ostatniemu zagraniu mamy już wszystkie kolory na miejscu
			notInPosition = 4 - @guessPrecision[@round-1][0]
			lastGuess = @guessHistory[@round-1].clone
			newGuess = nil
		#	if notInPosition == 4
				newGuess = lastGuess.shuffle
		#	else
		#			startPos = Random.new.rand(0..3)
		#			endPos = nil
		#		loop do
		#			endPos = Random.new.rand(0..3)
		#			break if endPos != startPos
		#		end
		#		newGuess = lastGuess
		#		x = lastGuess[startPos]
		#		newGuess [endPos] = x
		#	end	
		#	puts"--shuffling--"
		#	startPos = Random.new.rand(0..3)
		#	endPos = nil
		#	startPos2 = nil
		#	endPos2 = nil
		#	loop do
		#		endPos = Random.new.rand(0..3)
		#		break if endPos != startPos
		#	end
		#	puts "startPos #{startPos} endPos #{endPos}"
		#	if notInPosition == 4
		#		loop do
		#			startPos2 = Random.new.rand(0..3)
		#			endPos2 = Random.new.rand(0..3)
		#		break if (startPos2 != endPos2)&&(startPos2 != startPos)&&(startPos2 != endPos)
		#		end
		#	end
		#	puts "startPos2 #{startPos2} endPos2 #{endPos2}"
		#	newGuess = [lastGuess[startPos]]
			return newGuess
		end	
	end

	def randomGuess (num, last=nil)
		randGuess = []
		while randGuess.length < num
			# puts @board.colorsToChoose
			color = @board.colorsToChoose[Random.new.rand(0..5)]
			# puts color
			if !randGuess.include? color
				if last != nil
					if !last.include? color
						if !@forbidden.include? color
							randGuess << color
							# color
						end
					end
				else
					randGuess << color
					# color
				end

			end
		end
		return randGuess
	end
end