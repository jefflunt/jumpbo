class House
  include CardHolder

  attr_reader :cards

  def initialize
    @cards = {
      draw: [],
      discard: [],
      build1: [],
      build2: [],
      build3: [],
      build4: [],
    }
  end

  def deal(card, placement)
  end
end
