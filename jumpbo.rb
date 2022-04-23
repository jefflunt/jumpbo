require_relative './card_holder'

# Jumpbo is an implemenation of the game Skip-Bo.
#
# The game consists of many stacks of cards:
#
# - stock pile - the cards that the player is trying to use up; the first
#   player to use up all their stock pile wins the gae
# - discard piles (1-4) - each player has 4 discard piles of their own, that
#   only they can play on, and which a player can discard any card from their
#   hand onto
# - building piles (1-4) - the set of four piles in the center of the play area
#   upon which players can play any of their cards to count up from 1-12, and
#   then wrap around again. Jumpbo cards can be used as a wild card in place of
#   any other card in a building pile
# - deck, or draw pile - the stack of cards from which players can draw to
#   bring their hand up to 5 cards as the beginning of their turn. when the draw
#   pile runs out of cards, all but the top cards of the building piles are
#   returned to the draw pile and shuffled to provide for continuous play until
#   one player uses all of their stock pile cards
class Jumpbo
  GAME_CARDS = ([0] * 18) + (1..12).map{|n| [n] * 12 }.flatten
  CARDS_PER_PLAYER = {
    2 => 30,
    3 => 30,
    4 => 20,
    5 => 20,
  }

  attr_reader :game_cards,
              :players,
              :turn,
              :winner

  def initialize(player_count)
    @turn = 0
    @winner = nil
    @game_cards = CardHolder.new('Game Cards', nil, :draw, :build1, :build2, :build3, :build4)
    p @game_cards
    GAME_CARDS.shuffle.each{|c| @game_cards.push(:draw, c) }

    @players = []
    player_count.times do |n|
      @players.push(
        CardHolder.new(
          "Player #{n + 1}",
          nil,
          :hand,
          :stock,
          :discard1,
          :discard2,
          :discard3,
          :discard4
        )
      )
    end

    players.each do |p|
      CARDS_PER_PLAYER[player_count].times{ p.push(:stock, game_cards.pop(:draw)) }
    end
  end

  def play_game
    loop do
      puts "TURN #{turn + 1}, Player #{player_i + 1}"
      _take_turn

      break if _game_over?
    end
  end

  def player_i
    turn % players.size
  end

  def to_s
    <<~DEBUG
      #{game_cards}
      Player count: #{players.size}
      #{players.map(&:to_s).join("\n")}
       #{'WINNER:'.green} #{winner ? players[player_i - 1].label : '<none>'}
    DEBUG
  end

  def _take_turn
    loop do
      break unless _apply_move(players[player_i].make_move(nil))
    end

    @turn += 1
  end

  def _apply_move(player_move)
    players[player_i].pop(:stock) if rand(2) == 0
  end

  def _game_over?
    !!(@winner = players.detect{|p| p[:stock].size == 0 })
  end
end
