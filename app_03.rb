require "pry"
require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/colorizeString'

def init
  system('clear')
  title_art = File.read("#{__dir__}/assets/poofighter.txt")
  puts title_art.red
  puts puts
  puts " Affrontes les personnages du terminal dans un combat à mort !".bold
  puts puts
  sleep 1.5
end

def start
  init()
  game = Game.new
  system('clear')
  puts "Le combat se prépare !".bold
  sleep 1.5
  game.show_players
  while game.is_still_ongoing?
    game.menu
    game.menu_choice
    puts puts
    sleep 2.5
    game.ennemy_attacks
    system('clear')
  end
  system('clear')
  @ennemies == [] ? final_art = File.read("#{__dir__}/assets/victory.txt") : final_art = File.read("#{__dir__}/assets/defeat.txt")
  puts final_art
end

start()
# binding.pry
