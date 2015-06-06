require 'requirements'

describe "Board castling conditions" do

let(:board) { Board.create_new_board }

  describe "#toggle_castle" do

    it "toggles black king side when the black rook moves" do
      board.toggle_castle([0,7])
      expect(board.castling[:black_king_side]).to eq(false)
    end


    it "toggles black queen side when the black queen moves" do
      board.toggle_castle([0,0])
      expect(board.castling[:black_queen_side]).to eq(false)
    end

    it "toggles both black castling keys when the black king moves" do
      board.toggle_castle([0,4])
      expect(board.castling[:black_king_side]).to eq(false)
      expect(board.castling[:black_queen_side]).to eq(false)
    end

    it "toggles white king side when white king rook moves" do
      board.toggle_castle([7,7])
      expect(board.castling[:white_king_side]).to eq(false)
    end

    it "toggles white queen side when white queen rook moves" do |variable|
      board.toggle_castle([7,0])
      expect(board.castling[:white_queen_side]).to eq(false)
    end
    it "toggles both white castling keys when the white king moves" do
      board.toggle_castle([7,4])
      expect(board.castling[:white_king_side]).to eq(false)
      expect(board.castling[:white_queen_side]).to eq(false)
    end

  end
end
