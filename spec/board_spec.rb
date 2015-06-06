require 'requirements'

describe "Board castling conditions" do

let(:board) { Board.create_new_board }

  describe "#move toggles castling" do

    it "toggles black king side when given the right coordinates" do
      board.move([1,7], [3,7])
      board.move([0,7], [1,7])
      expect(board.castling[:black][:king_side]).to eq(false)
    end


    it "toggles black queen side when given the right coordinates" do
      board.move([1,0], [3,0])
      board.move([0,0], [1,0])
      expect(board.castling[:black][:queen_side]).to eq(false)
    end

    it "toggles both black castling keys when given the right coordinates" do
      board.move([1,4], [3,4])
      board.move([0,4], [1,4])
      expect(board.castling[:black].any? { |k, v| v == true }).to eq(false)
    end

    it "toggles white king side when given the right coordinates" do
      board.move([6,7],[5,7])
      board.move([7,7],[6,7])
      expect(board.castling[:white][:king_side]).to eq(false)
    end

    it "toggles white queen side when given the right coordinates" do
      board.move([6,0],[5,0])
      board.move([7,0], [6,0])
      expect(board.castling[:white][:queen_side]).to eq(false)
    end
    it "toggles both white castling keys when given the right coordinates" do
      board.move([6,4],[5,4])
      board.move([7,4], [6,4])
      expect(board.castling[:white].any? { |k, v| v == true }).to eq(false)

    end

  end

  describe "#clear_castle_path?" do

    it "returns true on black kingside when the path is clear" do
      board[[0,6]] = nil
      board[[0,5]] = nil
      expect(board.clear_castle_path?(:black, :king)).to eq(true)
    end

    it "returns true on black queenside when the path is clear" do
      board[[0,1]] = nil
      board[[0,2]] = nil
      board[[0,3]] = nil
      expect(board.clear_castle_path?(:black, :queen)).to eq(true)
    end

    it "returns false on black kingside when the path is blocked" do
      expect(board.clear_castle_path?(:black, :king)).to eq(false)
    end

    it "returns false on black queenside when the path is blocked" do
      expect(board.clear_castle_path?(:black, :queen)).to eq(false)
    end

    it "returns true on white kingside when the path is clear" do
      board[[7,6]] = nil
      board[[7,5]] = nil
      expect(board.clear_castle_path?(:white, :king)).to eq(true)
    end

    it "returns true on white queenside when the path is clear" do
      board[[7,1]] = nil
      board[[7,2]] = nil
      board[[7,3]] = nil
      expect(board.clear_castle_path?(:white, :queen)).to eq(true)
    end

    it "returns false on white kingside when the path is blocked" do
      expect(board.clear_castle_path?(:white, :king)).to eq(false)
    end

    it "returns false on white queenside when the path is blocked" do
      expect(board.clear_castle_path?(:white, :queen)).to eq(false)
    end
  end

  describe "#is_castling?" do

    it "returns true when king is trying to castle queenside"
    it "returns true when king is trying to castle kingside"
    it "returns false when king is not trying to castle"

  end

  describe "#castle" do

    it "moves the king to the kingside castle spot"
    it "moves the king to the queenside castle spot"
    it "moves the rook to the kingside castle spot"
    it "moves the rook to the queenside castle spot"

  end

end