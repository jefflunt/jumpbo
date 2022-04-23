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
  attr_reader :label

  # Takes a label (a friendly name for this CardHolder), and a list of
  # placements to initialize. The label can be any String, or nil
  def initialize(label, ai, *placements)
    @label = label
    @cards = {}
    placements.each{|p| @cards[p] = [] }
  end

  # Passes the following method calls down to CardHolder placements, which are
  # Arrays:
  # - #push
  # - #pop
  # - #shift
  # - #unshift
  #
  # ... and raises an error otherwise.
  #
  # Also raises an error if:
  # - the specified card is nil
  # - the specified placement is invalid
  def method_missing(method, placement, card=nil)
    raise NoMethodError.new("invalid method `#{method}' for #{self}:#{self.class.name}") unless %i(push pop shift unshift).include?(method)
    raise "invalid card placement, `#{placement}`" unless @cards[placement]
    raise "nil card passed to `#{method}'" if %i(push shift).include?(method) && card.nil?

    case method
    when :push, :shift
      @cards[placement].send(method, card)
    when :pop, :unshift
      @cards[placement].send(method)
    end
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

  def to_s(as_stack: true)
    <<~DEBUG
      #{@label}:
      #{
        @cards.map do |pl, cards|
          "#{pl.to_s.rjust(12)}: (#{self[pl].size}) " +
            "#{(as_stack ? cards.reverse : cards)[0..9].join(', ')}" +
            "#{cards.length > 10 ? ' ...' : ''}"
        end.join("\n")
      }
    DEBUG
  end

  #############################################
  # AI methods, which maybe should be moved out
  #############################################
  def make_move(board_state)
  end
end
