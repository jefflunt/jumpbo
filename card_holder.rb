# The CardHolder module implements a number of methods for dealing cards to,
# taking cards from, and peeking at cards from a class that includes this
# module.
#
# For exapmle, in a game of blackjack you have several card holders:
# - the deck from which cards are dealt
# - each player
# - the house
#
# Each cardholder also has a series of placements:
# - the deck has only a single stack of cards
# - each player has visible cards
# - the house has a visible card (one placement) and a hidden card (a different
#   placement)
#
# Placements are simply arrays of cards. Cords can be moved from one placement
# to another, or between players by using the normal ruby Array methods:
# - #shift
# - #unshift
# - #push
# - #pop
#
# Three additional methods are added to this module for convenience:
# - #peek(placement, place) returns the card at the beginning or end of the
#   specified placement and place (:front or :back of a placement Array)
# - #take(card, placement) removes and returns the specified card. If duplicate
#   cards are in athat placement then only one of them is removed and returned.
# - #can_take?(card, placement) returns true or false, indicating whether or
#   not the specified card exists in that placement. This is useful if you
#   simply want to know if a CardHolder has a given card without taking it.
module CardHolder
  def method_missing(method, card, placement)
    raise "nil card cannot be dealt" unless card
    raise "Invalid card placement, `#{placement}`" unless @cards[placement]

    @cards[placement].send(method, card)
  end

  # Return the list of placements available.
  def placements
    @cards.keys
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
end
