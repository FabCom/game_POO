class Game
  attr_accessor :player, :ennemies

  def initialize
    @player = init_user
    @ennemies = init_ennemies(4)
  end

  def kill_player(id_ennemy)
    @ennemies.delete_at(id_ennemy)
  end

  def is_still_ongoing?
    @player.life_points > 0 && ennemies != [] ? true : false
  end

  def show_players
    system('clear')
    puts puts
    puts "-" * (18 * 7)
    puts "                          ÉTAT DES COMBATTANTS".bold
    puts "                          ********************"
    puts puts
    puts "Joueur :".underline
    puts
    puts @player.show_state
    puts puts
    puts "Tu as #{@ennemies.length} ennemies à affronter :".underline
    puts
    @ennemies.each {|ennemy| puts ennemy.show_state ; puts}
    puts "-" * (18 * 7)
    gets.chomp
    system('clear')
  end

  def menu
    puts "                         C'est à ton tour de jouer !".bold
    puts puts
    puts @player.show_state
    puts puts
    puts "Quelle action veux-tu effectuer ?".bold
    puts
    puts "a".magenta + ": Attaquer    " + "s".magenta + " : Chercher une arme    " + "h".magenta + " : Chercher du soin     " + "e".magenta + " : voir l'état de la partie"
    print "> "
  end

  def menu_choice
    input_action = gets.chomp
    case input_action
    when "s"
      @player.search_weapon
    when "h"
      @player.search_health_pack
    when "a"
      attack_action()
    when "e"
      show_players()
    else
      puts "Je n'ai pas compris ce que tu voulais faire..."
      sleep 1.5
      menu()
    end
  end

  def attack_action
    puts puts
    puts "Quel ennemie veux-tu attaquer ?".bold
    @ennemies.each_with_index do |ennemy, index|
      print index.to_s.magenta ; puts " : " + ennemy.show_state
    end
      print "> "
      begin
        input_ennemy = Integer(gets.chomp)
      rescue
        puts "Je n'ai pas compris qui tu voudrais attaquer.".gray
        attack_action()
      end
      if @ennemies.at(input_ennemy) != nil
        @player.attacks(@ennemies[input_ennemy])
        if @ennemies[input_ennemy].life_points <= 0
          kill_player(input_ennemy)
        end
      else
        puts "Attends cet ennemie n'est pas encore là, il arrive t'inquiète !".gray
        sleep 1.5
        attack_action()
      end
  end

  def ennemy_attacks
    system('clear')
    puts "                         C'est au tour des ennemies de t'attaquer !".bold
    @ennemies.each do |ennemy|
      ennemy.attacks(@player)
      sleep 1.5
      if @player.life_points <= 0
        puts puts
        puts "Tu es mort !".red.blink
      end
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
end
