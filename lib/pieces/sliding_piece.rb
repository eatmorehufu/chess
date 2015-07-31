class SlidingPiece < Piece

  ROOK_DELTAS = [
    [ 1, 0],
    [ 0, 1],
    [ 0,-1],
    [-1, 0]
  ]

  BISHOP_DELTAS = [
    [ 1, 1],
    [ 1,-1],
    [-1, 1],
    [-1,-1]
  ]

  def moves
    valid_moves = []

    move_dirs.each do |dir|
      1.upto(Board::BOARD_SIZE - 1) do |distance|
        test_coord = [
          distance * dir.first + @pos.first,
          distance * dir.last + @pos.last
        ]

        if !Board.in_bounds?(test_coord) ||
            @board.occupied_by_ally?(test_coord, @color)
          break
        end

        valid_moves << test_coord
        break if @board.occupied_by_enemy?(test_coord, @color)

      end
    end

    valid_moves
  end

  def move_dirs
    raise NotImplementedError
  end

end
