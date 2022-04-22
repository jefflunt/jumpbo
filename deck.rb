class Deck
  attr_reader :cards

  def initialize
    @cards = ([0] * 18) +
      (1..12).map{|n| [n] * 12 }
      .flatten
  end

  def shuffle!
    @cards.shuffle!
  end
end
