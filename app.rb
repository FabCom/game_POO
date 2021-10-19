require "pry"
require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/colorizeString'

def state_of_players_display(left_player, right_player)
  puts puts
  puts "-" * (18 * 7)
  puts "                          ÉTAT DES COMBATTANTS"
  puts "                          ********************"
  puts puts
  puts "À ma gauche :"
  puts left_player.show_state
  puts "                                                                                         À ma droite :"
  print "                                                                                         " ; puts right_player.show_state
  puts "-" * (18 * 7)
  puts puts
end
def round(left_player, right_player)
  while left_player.life_points > 0 && right_player.life_points > 0
    state_of_players_display(left_player, right_player)
    sleep 1.5
    left_player.attacks(right_player)
    sleep 1.5
    if right_player.life_points <= 0
      break
    end
    puts puts
    print "                                     "
    right_player.attacks(left_player)
    sleep 1.5
  end
end
def start
  system('clear')
  puts " Deux joueurs s'affrontent dans ce combat à mort !"
  left_player = Player.new("José")
  right_player = Player.new("Sam")
  puts puts
  puts "Le combat commence !"
  sleep 1.5
  puts puts
  round(left_player, right_player)
end

start()


# player1.attacks(player2)
# binding.pry
