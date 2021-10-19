class Game
  attr_accessor :player, :ennemies

  def initialize
    begin_display()
    @player = init_user
    @ennemies = init_ennemies(1)
    count_display()
  end

  def kill_player(id_ennemy)
    @ennemies.delete_at(id_ennemy)
  end

  def is_still_ongoing?
    @player.life_points > 0 && @ennemies != [] ? true : false
  end

  def begin_display
    system('clear')
    title_art = File.read("#{__dir__}/../assets/poofighter.txt")
    puts title_art.red
    puts puts
    puts " Affrontes les personnages du terminal dans un combat à mort !".bold
    puts puts
    sleep 1.5
  end

  def count_display
    system('clear')
    print "\n" * 4
    puts "Prêt à combattre !".bold
    sleep 1
    system('clear')
    print "\n" * 4
    puts File.read("#{__dir__}/../assets/three.txt").red
    sleep 1
    system('clear')
    print "\n" * 4
    puts File.read("#{__dir__}/../assets/two.txt").red
    sleep 1
    system('clear')
    print "\n" * 4
    puts File.read("#{__dir__}/../assets/one.txt").red
    sleep 1
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
    puts "                                                                      Appuie sur la touche ENTER"
    gets.chomp
    system('clear')
  end

  def menu
    system('clear')
    puts "                         C'est à ton tour de jouer !".bold
    puts puts
    puts @player.show_state
    puts puts
    puts "Quelle action veux-tu effectuer ?".bold
    puts
    puts "a".magenta + ": Attaquer    " + "s".magenta + " : Chercher une arme    " + "h".magenta + " : Chercher du soin     " + "e".magenta + " : voir l'état de la partie"
    print "> "
    menu_choice()
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
        puts "Attends, cet ennemie n'est pas encore là, il arrive t'inquiète !".gray
        sleep 1.5
        attack_action()
      end
  end

  def ennemy_attacks
    unless @ennemies == [] then
      system('clear')
      puts "                         C'est au tour des ennemies de t'attaquer !".bold
      sleep 1.5
      @ennemies.each do |ennemy|
        ennemy.attacks(@player)
        sleep 1.5
        if @player.life_points <= 0
          puts puts
          puts "Tu es mort !".red.blink
          break
        end
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
    list_name_ennemies = ["Acolyte du Crépuscule d'Argent", "Goule de Cimetière", "Serpent de Yig", "Guetteur d'une Autre Dimension","Bête Déchaînée", "Bête Sacrificielle", "Agents de l'Ombre"]
    ennemies = Array.new()
    list_name_ennemies.sample(number).each do |name|
      ennemies.push(Player.new(name))
    end
    return ennemies
  end
end
