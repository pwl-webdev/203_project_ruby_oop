require 'spec_helper'
require 'tictactoe'

describe TicTacToe do
	subject do
		TicTacToe.new()
	end
	describe "#gameSetup" do
	 	it "sets up board and players" do
	 		subject.stub(:gets).and_return("o\n")
			subject.gameSetup()
	 		expect(subject.player1.symbol).to eql("o")
	 		expect(subject.player1.move).to be_truthy
	 	end
	 	it "quits and return input if typed 'quit'" do
	 		subject.stub(:gets).and_return("quit\n")
			expect(subject.gameSetup()).to eql("quit")
	 	end
	end
end