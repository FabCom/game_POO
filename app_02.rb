require "pry"
require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/colorizeString'

def state_of_players_display(user, ennemies)
  system('clear')
  puts puts
  puts "-" * (18 * 7)
  puts "                          ÉTAT DES COMBATTANTS".bold
  puts "                          ********************"
  puts puts
  puts "Joueur :".underline
  puts
  puts user.show_state
  puts puts
  puts "Ennemies que tu vas affronter dans cette partie :".underline
  puts
  ennemies.each {|ennemy| puts ennemy.show_state ; puts}
  puts "-" * (18 * 7)
  puts puts
  sleep 3
  system('clear')

end

def user_attack(user, ennemies)
  puts puts
  puts "Quel ennemie veux-tu attaquer ?".bold
  ennemies.each_with_index do |ennemy, index|
    print index.to_s.magenta ; puts " : " + ennemy.show_state
  end
    print "> "
    begin
      input_ennemy = Integer(gets.chomp)
    rescue
      puts "Je n'ai pas compris qui tu veux attaquer.".gray
      user_attack(user, ennemies)
    end
    if ennemies.at(input_ennemy) != nil
      user.attacks(ennemies[input_ennemy])
      if ennemies[input_ennemy].life_points <= 0
        ennemies.delete_at(input_ennemy)
      end
    else
      puts "Je n'ai pas compris qui tu veux attaquer.".gray
      sleep 1.5
      user_attack(user, ennemies)
    end
end

def user_turn(user, ennemies)
  system('clear')
  puts "                         C'est à ton tour de jouer !".bold
  puts puts
  puts user.show_state
  puts puts
  puts "Quelle action veux-tu effectuer ?".bold
  puts
  puts "a".magenta + ": Attaquer    " + "s".magenta + " : Chercher une arme    " + "h".magenta + " : Chercher du soin"
  print "> "
  input_action = gets.chomp
  case input_action
  when "s"
    user.search_weapon
  when "h"
    user.search_health_pack
  when "a"
    user_attack(user, ennemies)
  else
    puts "Je n'ai pas compris ce que tu voulais faire..."
    sleep 1.5
    user_turn(user, ennemies)
  end
end

def ennemy_turn(user, ennemies)
  system('clear')
  puts "                         C'est au tour des ennemies de t'attaquer !".bold
  ennemies.each do |ennemy|
    ennemy.attacks(user)
    sleep 1.5
    if user.life_points <= 0
      puts puts
      puts "Tu es mort !".red
    end
  end
end

def round(user, ennemies)
  while user.life_points > 0 && ennemies != []
    user_turn(user, ennemies)
    puts puts
    sleep 2.5
    ennemy_turn(user, ennemies)
  end
end

def init_user
  puts "C'est quoi ton blaze ?"
  print "> "
  name = gets.chomp
  return HumanPlayer.new(name)
end

def init_ennemies(number)
  list_name_ennemies = ["Acolyte du Crépuscule d'Argent", "Goule de Cimetière", "Serpent de Yig", "Guetteur d'une Autre Dimension"]
  ennemies = Array.new()
  list_name_ennemies.sample(number).each do |name|
    ennemies.push(Player.new(name))
  end
  return ennemies
end
def start
  system('clear')
  title_art = File.read("#{__dir__}/assets/poofighter.txt")
  puts title_art.red
  puts puts
  puts " Affrontes les personnages du terminal dans un combat à mort !".bold
  puts puts
  sleep 1.5
  user = init_user()
  puts puts
  ennemies = init_ennemies(2)
  puts "Le combat commence !".bold
  sleep 1.5
  puts puts
  puts
  state_of_players_display(user, ennemies)
  round(user, ennemies)
  puts puts
  system('clear')
  ennemies == [] ? final_art = File.read("#{__dir__}/assets/victory.txt") : final_art = File.read("#{__dir__}/assets/defeat.txt")
  puts final_art
end

start()
binding.pry
