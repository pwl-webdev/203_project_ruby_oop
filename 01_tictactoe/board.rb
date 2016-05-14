class Board
	require_relative 'player.rb'
	def initialize()
		@board = [[" ", " "," "],[" ", " "," "],[" ", " "," "]]

	end

	def reset()
		@board = [[" ", " "," "],[" ", " "," "],[" ", " "," "]]
	end

	def display()
		puts "  1 | 2 | 3 "
		@board.each_with_index do |x, xi|
			print xi+1
			x.each_with_index do |y, yi|
				print " "+y+" "
				if yi < 2
					print "|"
				end
			end
			puts""
		end
	end

	def performMove(player)
		moveOK = false
		while !moveOK
			puts "Player '#{player.symbol}' select your move 11 - 33 (ColumnRow)"
			answer = gets.chomp
			answer = answer.split("")
			if answer[0].to_i.between?(1,3) && answer[1].to_i.between?(1,3)
				# puts "column #{answer[0]} row #{answer[1]}"
				if updateBoard(answer[0].to_i, answer[1].to_i, player.symbol)
					moveOK = true
				end
			end
		end
		return true
	end

	def victory?
		victory = false
		draw = false
		symbol = nil
		@board.each do |row|
			if row.count("x") == 3 
				victory = true,
				symbol = "x"
			#	puts "row won"
			elsif row.count("o") == 3
				victory = true
				symbol = "o"
			#	puts "row won"
			end
		end
		3.times do |i|
			x = 0
			o = 0
			3.times do |j|
				@board[j-1][i-1] == "x" ? x += 1: nil
				@board[j-1][i-1] == "o" ? o += 1: nil
			end
			if x == 3
				victory = true,
				symbol = "x"
			#	puts "column won"
			elsif o == 3
				victory = true
				symbol = "o"
			#	puts "column won"
			end
		end
		if (@board[0][0] == @board[1][1])&&(@board[1][1] == @board[2][2])&&@board[0][0]!=" "
			victory = true
			symbol = @board[0][0]
			# puts "diagonal won"
		end
		if (@board[2][0] == @board[1][1])&&(@board[1][1] == @board[0][2])&&@board[2][0]!=" "
			victory = true
			symbol = @board[2][0]
			# puts "diagonal won"
		end
		x = @board.join
		if !(x.include? " ")
			draw = true
		end
		if victory
			puts "!!! #{symbol} won the game !!!"
			return victory
		elsif draw
			puts "!!! It's a draw !!!"
			return draw
		end
	end

	private
	def updateBoard (column, row, symbol)
		if @board[row-1][column-1] == " "
			@board[row-1][column-1] = symbol
			return true
		else
			return false
		end
	end	
end
