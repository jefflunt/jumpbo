# The CardHolder class implements a number of methods for dealing cards to,
# taking cards from, and peeking at named groups of cards. Imagine a game of
# blackjack: a CardHolder instance could represent a player, our the house. In
# a game like Uno it could represent the draw and discard piles that everyone
# shares, or a player's hand.
#
# A CardHolder is really just a logical container for 1 or more named groups of
# cards.
#
# Placements are simply arrays of cards. Cords can be moved from one placement
# to another, or between players by using the normal ruby Array methods:
# - #shift
# - #unshift
# - #push
# - #pop
#
# In addition to the normal Array methods, three additional methods are addeto
# this class for convenience:
# - #peek(placement, place) returns the card at the beginning or end of the
#   specified placement and place (:front or :back of a placement Array)
# - #take(card, placement) removes and returns the specified card. If duplicate
#   cards are in athat placement then only one of them is removed and returned.
# - #can_take?(card, placement) returns true or false, indicating whether or
#   not the specified card exists in that placement. This is useful if you
#   simply want to know if a CardHolder has a given card without taking it.
class CardHolder
  def initialize(*placements)
    @cards = {}
    placements.each{|p| @cards[p] = [] }
  end

  # Passes method calls through to the underlying card placements
  def method_missing(method, *args, &block)
    raise NoMethodError("invalid method `#{method}' for #{self}:#{self.class.name}") unless %i(push pop shuft unshift).include?(method)
    raise "nil card passed to `#{method}'" unless card
    raise "invalid card placement, `#{placement}`" unless @cards[placement]

    @cards[placement].send(method, card)
  end

  # Return the list of placements available.
  def placements
    @cards.keys
  end

  def [](placement)
    @cards[placement]
  end

  # Returns the card at the specified placement, and place.
  #
  # Valid places are :front (beginning) or :back (end) of the placement.
  def peek(placement, place)
    return unless @cards[placement]
    return unless [:front, :back].include?(place)

    @cards[placement][place == :front ? 0 : -1]
  end

  # Removes and returns the specified card if it exists in the specified placement; nil otherwise.
  def take(card, placement)
    return unless can_take?(card, placement)
    @cards[placement].delete_at(@cards.index(card))
  end

  # Returns true if the specified card exists in the specified placement; false
  # otherwise.
  def can_take?(card, placement)
    !@cards[placement].nil? && !!@cards[placement]
  end

  def shuffle!(placement)
    @cards[placement].shuffle!
  end
end
