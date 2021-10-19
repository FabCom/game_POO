class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    return "#{self.name}".brown + " a #{self.life_points} points de vie"
  end

  def gets_damage(damages)
    self.life_points -= damages
    if self.life_points <= 0
      puts puts
      puts "#{self.name} a été tué"
      self.life_points = 0
    end
  end

  def attacks(player_defender)
    damages = compute_damage()
    puts puts
    puts "#{self.name}".brown + " attaque #{player_defender.name} et lui inflige " +"#{damages}".red + " points de dégats"
    player_defender.gets_damage(damages)
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    return "#{self.name} a " + "#{self.life_points}".green + " points de vie et une arme de niveau #{self.weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts puts
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level > self.weapon_level
     self.weapon_level = new_weapon_level
     puts puts
     puts "Tu échanges ton arme actuelle pour cette nouvelle arme.".blue
    else
      puts puts
      puts "Cette arme n'est pas meilleure, tu gardes celle que tu as."
    end
  end

  def gain_life(gain)
    self.life_points += 50
    if self.life_points > 100 then self.life_points=100 end
    puts "Tu as trouvé un pack de #{gain} points de vie !".green
  end

  def search_health_pack
    result = rand(1..6)
    case result
    when 1
      puts "Tu n'as rien trouvé... Retournes combattre ou retentes ta chance !"
    when 2..5
      gain_life(50)
    when 6
      gain_life(80)
    end
  end
end
