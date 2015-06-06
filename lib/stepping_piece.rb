class SteppingPiece < Piece

  KNIGHT_DELTAS = [
    [ 2,  1],
    [ 2, -1],
    [ 1,  2],
    [ 1, -2],
    [-1,  2],
    [-1, -2],
    [-2,  1],
    [-2, -1]
  ]

  KING_DELTAS = [
    [ 1,  1],
    [ 1,  0],
    [ 1, -1],
    [ 0,  1],
    [ 0, -1],
    [-1,  1],
    [-1,  0],
    [-1, -1]
  ]

  def deltas
    raise NotImplementedError
  end

  def moves
    deltas.map do |delta_rank, delta_file|
      [@pos.first + delta_rank, @pos.last + delta_file]
    end.select do |coord|
      Board.in_bounds?(coord) &&
        !@board.occupied_by_ally?(coord, @color)
    end
  end


end
