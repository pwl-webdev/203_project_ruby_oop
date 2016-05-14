require_relative 'board.rb'

class Player
	def initialize
		@guessHistory = {}
		@round = 1
		@guessPrecision = {}
		@board = Board.new()
	end

	def playGame()
		gameON = true
		while gameON do
			#@board.displayCode
			oneLiner()
			inputOK = true
			input = gets.chomp.upcase
			input = input.split("")
			input.length == 4 ? inputOK = true : inputOK = false
			input.each do |i|
				if !"RGBYCM".include? i
					inputOK = false
				end	
			end

			if !inputOK
				puts "Wrong input"
				next
			end

			if inputOK
				makeAGuess(input)
				displayHistory()
				gameON = !checkVictory()
				#puts "gameOn "+gameON.to_s
			end
		end
	end

	def oneLiner()
		puts "Guess 4 colors in order (use \e[31mR\e[0m \e[32mG\e[0m \e[34mB\e[0m \e[33mY\e[0m \e[36mC\e[0m \e[35mM\e[0m):"
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
			return true
		else
			return false
		end
	end

	def makeAGuess(guess)
		@guessHistory[@round] = guess
		@guessPrecision[@round] = @board.checkAGuess(guess)
		#puts "-----guessHistory"
		#puts @guessHistory
		#puts "-----guessPrecision"
		#puts @guessPrecision
		@round += 1
	end

	def displayHistory
		puts "                Match   Contains"
		@guessHistory.each_pair do |key, value|
			print "#{key.to_s.rjust(2)})   "
			displayColor(value)
			 print "| #{@guessPrecision[key][0]}       #{@guessPrecision[key][1]}"
			 puts""
		end
	end

	def displayColor(tab)
		#puts "in display color"
		#puts tab
		tab.each do |iter|
			case iter
			when "R" then print "\e[31m#{iter}\e[0m "
			when "G" then print "\e[32m#{iter}\e[0m "
			when "B" then print "\e[34m#{iter}\e[0m "
			when "Y" then print "\e[33m#{iter}\e[0m "
			when "C" then print "\e[36m#{iter}\e[0m "
			when "M" then print "\e[35m#{iter}\e[0m "
			end
		end
	end
end