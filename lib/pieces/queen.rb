class Queen < SlidingPiece

  def move_dirs
    SlidingPiece::ROOK_DELTAS + SlidingPiece::BISHOP_DELTAS
  end

  def inspect
    "#{color.to_s[0]}Q "
  end

end
