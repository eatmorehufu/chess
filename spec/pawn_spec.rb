describe "Pawn" do

  let(:board) { Board.create_new_board }

  describe "#moves for en_passant" do


    let!(:en_passanting) do
      board.move([1,1], [3,1])
      board.move([3,1], [4,1])
    end

    it "includes the en-passantable move in moves" do
      board.move([6,2], [4,2])
      expect(board[[4,1]].moves.include?([5,2])).to eq(true)
    end
    it "doesn't include en-passant move if pawn moved one space" do
      board.move([6,2], [5,2])
      board.move([5,2], [4,2])
      expect(board[[4,1]].moves.include?([5,2])).to eq(false)
    end
  end


end
