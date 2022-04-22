require_relative './card_holder'

class Jumpbo
  GAME_CARDS = ([0] * 18) + (1..12).map{|n| [n] * 12 }.flatten
  CARDS_PER_PLAYER = {
    2 => 30,
    3 => 30,
    4 => 20,
    5 => 20,
  }

  attr_reader :deck,
              :players,
              :turn

  def initialize(player_count)
    @turn = 0
    @deck = CardHolder.new('Deck', :draw)
    GAME_CARDS.shuffle.each{|c| @deck.push(:draw, c) }

    @players = []
    player_count.times{|n| @players << CardHolder.new("Player #{n + 1}", :hand, :stock, :discard1, :discard2, :discard3, :discard4) }

    players.each do |p|
      CARDS_PER_PLAYER[player_count].times{ p.push(:stock, deck.pop(:draw)) }
    end
  end

  def take_turn
    @turn += 1
  end

  def player_i
    turn % players.size
  end

  def to_s
    <<~DEBUG
         Deck: #{deck[:draw].size}
      Players: #{players.size}
      #{players.map(&:to_s).join("\n")}
    DEBUG
  end
end
