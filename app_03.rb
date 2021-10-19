require "pry"
require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/colorizeString'

def start
  game = Game.new(4)
  game.show_players
  while game.is_still_ongoing?
    game.menu
    puts puts
    sleep 2.5
    game.ennemy_attacks
    system('clear')
  end
  system('clear')
  game.ennemies == [] ? final_art = File.read("#{__dir__}/assets/victory.txt").green : final_art = File.read("#{__dir__}/assets/defeat.txt").red
  puts final_art
end

start()
# binding.pry
