class King < SteppingPiece

  def deltas
    SteppingPiece::KING_DELTAS
  end

  def inspect
    "#{color.to_s[0]}K "
  end

end
