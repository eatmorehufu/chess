require 'requirements.rb'

describe "King castling" do
let(:board) { Board.create_new_board }

  describe "#moves" do

    it "adds the castling position kingside to moves if he can castle" do
      board.move([1,6],[2,6])
      board.move([0,6],[2,7])
      board.move([0,5],[1,6])
      expect(board[[0,4]].moves.include?([0,6])).to eq(true)
    end

    it "adds the castling position queenside to moves if he can castle" do
      board.move([1,3],[3,3])
      board.move([0,1],[2,0])
      board.move([0,3],[2,3])
      board.move([0,2],[1,3])
      expect(board[[0,4]].moves.include?([0,1])).to eq(true)
    end

  end

end