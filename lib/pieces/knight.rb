class Knight < SteppingPiece

  def deltas
    SteppingPiece::KNIGHT_DELTAS
  end

  def inspect
    "#{color.to_s[0]}N "
  end

end
