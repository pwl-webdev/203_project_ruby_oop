require 'spec_helper'
require 'board'


describe Board do
	subject do
		Board.new()
	end

	let(:p1) {Player.new("x",true)}
	let(:p2) {Player.new("o",false)}

	context "after creating Board object" do
 		it "board is initialized and empty" do
 			expect(subject.board).to eql([[" ", " "," "],[" ", " "," "],[" ", " "," "]])
 		end
 	end

 	describe "#performMove" do
	 	it "detects criteria for game stop when game won (row)" do
	 		subject.stub(:gets).and_return("11\n","12\n","21\n","22\n","31\n")
	 		subject.performMove(p1)
	 		subject.performMove(p2)
	 		subject.performMove(p1)
	 		subject.performMove(p2)
	 		subject.performMove(p1)
	 		expect(subject.board).to eql([["x","x","x"],["o","o"," "],[" "," "," "]])
	 		expect(subject.victory?).to be_truthy
	 	end
	end
	
 	describe "#performMove" do
	 	it "detects criteria for game stop when game won (column)" do
	 		subject.stub(:gets).and_return("11\n","21\n","12\n","31\n","13\n")
	 		subject.performMove(p1)
	 		subject.performMove(p2)
	 		subject.performMove(p1)
	 		subject.performMove(p2)
	 		subject.performMove(p1)
	 		expect(subject.board).to eql([["x","o","o"],["x"," "," "],["x"," "," "]])
	 		expect(subject.victory?).to be_truthy
	 	end
	end
	describe "#performMove" do
	 	it "detects criteria for game stop when game won (diagonal)" do
	 		subject.stub(:gets).and_return("13\n","11\n","31\n","22\n","23\n","33\n")
	 		subject.performMove(p1)
	 		subject.performMove(p2)
	 		subject.performMove(p1)
	 		subject.performMove(p2)
	 		subject.performMove(p1)
	 		subject.performMove(p2)
	 		expect(subject.board).to eql([["o"," ","x"],[" ","o"," "],["x","x","o"]])
	 		expect(subject.victory?).to be_truthy
	 	end
	end
end