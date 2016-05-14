require_relative 'player.rb'

class Board
	attr_reader :colorsToChoose
	def initialize()
		@colorsToChoose = ["R","G","B","Y","C","M"]
		@secretCode = []
		randomCode()
	end

	def checkAGuess(guess)
		match = 0
		contain = 0
		guess.each_with_index do |item, index|
			if @secretCode.join.include? item
				contain += 1
			end
			if @secretCode[index] == item
				match += 1
			end
		end
		return [match, contain]
	end

	def randomCode ()
		while @secretCode.length < 4
			color = @colorsToChoose[Random.new.rand(0..5)]
			if !@secretCode.include? color
				@secretCode << color
			end
		end
	end

	def displayCode
		@secretCode.each do |iter|
			case iter
			when "R" then print "\e[31m#{iter}\e[0m "
			when "G" then print "\e[32m#{iter}\e[0m "
			when "B" then print "\e[34m#{iter}\e[0m "
			when "Y" then print "\e[33m#{iter}\e[0m "
			when "C" then print "\e[36m#{iter}\e[0m "
			when "M" then print "\e[35m#{iter}\e[0m "
			end
		end
		puts ""
	end

	def displayAllColors
		@colorsToChoose.each do |iter|
			case iter
			when "R" then print "\e[31m#{iter}\e[0m "
			when "G" then print "\e[32m#{iter}\e[0m "
			when "B" then print "\e[34m#{iter}\e[0m "
			when "Y" then print "\e[33m#{iter}\e[0m "
			when "C" then print "\e[36m#{iter}\e[0m "
			when "M" then print "\e[35m#{iter}\e[0m "
			end
		end
		puts ""
	end
end

#x = Board.new
#x.displayCode
#x.displayAllColors