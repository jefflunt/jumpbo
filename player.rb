class Player
  include CardHolder

  attr_reader :cards

  def initialize
    @cards = {
      hand: [],
      stock: [],
      discard1: [],
      discard2: [],
      discard3: [],
      discard4: [],
    }
  end

end
