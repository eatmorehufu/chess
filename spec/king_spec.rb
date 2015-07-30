require 'requirements'

describe "King castling" do
let(:board) { Board.create_new_board }

  describe "#moves" do

    it "adds the castling position kingside to moves if he can castle" do
      board[[0,6]] = nil
      board[[0,5]] = nil
      expect(board[[0,4]].moves.include?([0,6])).to eq(true)
    end

    it "adds the castling position queenside to moves if he can castle" do
      board[[0,1]] = nil
      board[[0,3]] = nil
      board[[0,2]] = nil
      expect(board[[0,4]].moves.include?([0,1])).to eq(true)
    end

  end

end
