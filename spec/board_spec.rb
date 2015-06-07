require 'requirements'
require 'byebug'

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

  describe "#move when castling" do

    let!(:castle_board) do
      board[[7,5]] = nil
      board[[7,6]] = nil
      board[[7,1]] = nil
      board[[7,2]] = nil
      board[[7,3]] = nil
    end

    it "moves the king to the kingside castle spot" do
      board.move([7,4], [7,6])
      expect(board[[7,6]].class).to eq(King)
    end
    it "moves the king to the queenside castle spot" do
      board.move([7,4], [7,1])
      expect(board[[7,1]].class).to eq(King)
    end
    it "moves the rook to the kingside castle spot" do
      board.move([7,4], [7,6])
      expect(board[[7,5]].class).to eq(Rook)
    end
    it "moves the rook to the queenside castle spot" do
      board.move([7,4], [7,1])
      expect(board[[7,2]].class).to eq(Rook)
    end

  end

  describe "#move when en-passanting" do

    let!(:en_passant_board) do
      board.move([1,1], [3,1])
      board.move([3,1], [4,1])
      board.move([6,2], [4,2])
      board.move([4,1], [5,2])
    end

    it "lets the pawn move into the en-passant space" do
      expect(board[[5,2]].class).to eq(Pawn)
    end

    it "captures the en-passanted pawn" do
      expect(board[[4,2]].class).to_not eq(Pawn)
    end

  end

  describe "board@en_passant" do

  let!(:en_pas_move) { board.move([6,2], [4,2]) }

    it "marks the last pawn to move as the en_passant pawn" do
      expect(board.en_passant).to eq([5,2])
    end

    it "removes the pawn from en_passant after the next turn" do
      allow(board).to receive(:in_check?).and_return(false)
      board.move([4,2], [3,2])
      expect(board.en_passant).to eq([])
    end

    it "replaces the pawn if next move is en_passantable pawn" do
      board.move([1,1], [3,1])
      expect(board.en_passant). to eq([2,1])
    end

  end

end
