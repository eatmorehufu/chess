require 'requirements'

describe "Board castling conditions" do

let(:board) { Board.create_new_board }

  describe "#toggle_castle" do

    it "toggles black king side when given the right coordinates" do
      board.toggle_castle([0,7])
      expect(board.castling[:black_king_side]).to eq(false)
    end


    it "toggles black queen side when given the right coordinates" do
      board.toggle_castle([0,0])
      expect(board.castling[:black_queen_side]).to eq(false)
    end

    it "toggles both black castling keys when given the right coordinates" do
      board.toggle_castle([0,4])
      expect(board.castling[:black_king_side]).to eq(false)
      expect(board.castling[:black_queen_side]).to eq(false)
    end

    it "toggles white king side when given the right coordinates" do
      board.toggle_castle([7,7])
      expect(board.castling[:white_king_side]).to eq(false)
    end

    it "toggles white queen side when given the right coordinates" do
      board.toggle_castle([7,0])
      expect(board.castling[:white_queen_side]).to eq(false)
    end
    it "toggles both white castling keys when given the right coordinates" do
      board.toggle_castle([7,4])
      expect(board.castling[:white_king_side]).to eq(false)
      expect(board.castling[:white_queen_side]).to eq(false)
    end

  end

  describe "#clear_castle_path?" do

    it "returns true on black kingside when the path is clear" do

    end

    it "returns true on black queenside when the path is clear"
    it "returns false on black kingside when the path is blocked" do
      expect(board.clear_castle_path?(:black, :king)).to eq(false)
    end
    it "returns false on black queenside when the path is blocked" do
      expect(board.clear_castle_path?(:black, :queen)).to eq(false)
    end
    it "returns true on white kingside when the path is clear"
    it "returns true on white queenside when the path is clear"
    it "returns false on white kingside when the path is blocked" do
      expect(board.clear_castle_path?(:white, :king)).to eq(false)
    end
    it "returns false on white queenside when the path is blocked" do
      expect(board.clear_castle_path?(:white, :queen)).to eq(false)
    end


  end
end
