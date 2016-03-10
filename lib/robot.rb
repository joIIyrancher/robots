require_relative 'weapon'

WEIGHT_CAPACITY = 250
DEFAULT_ATTACK = 5

class Robot

  # Custom Error Classes
  class RobotAlreadyDeadError < StandardError
  end

  class UnattackableEnemy < StandardError
  end
  
  attr_reader :position, :items
  attr_accessor :equipped_weapon, :health

  def initialize
    @health = 100
    @equipped_weapon = nil
    @position = [0,0]
    @items = []
  end

  ### ACTIONS
  # Movement Actions
  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  # Item-related Actions
  def pick_up(item)
    item.feed(self) if item.is_a? BoxOfBolts and self.health <= 80
    @equipped_weapon = item if item.is_a? Weapon
    @items << item if items_weight + item.weight <= WEIGHT_CAPACITY
  end

  def items_weight
    @items.inject(0) { |sum, item| sum + item.weight }
  end

  # Health-related Actions
  def wound(points)
    self.health -= points
    self.health = 0 if self.health < 0
  end

  def heal(points)
    heal!
    self.health += points
    self.health = 100 if self.health > 100
    self.health
  end

  def heal!
    raise RobotAlreadyDeadError, "Cannot heal a dead robot" if @health <= 0
  end

  # Robot-related Actions
  def attack(other_robot)
    attack!(other_robot)
    if within_reach?(other_robot)
      @equipped_weapon == nil ? other_robot.wound(DEFAULT_ATTACK) : @equipped_weapon.hit(other_robot)
      drop_weapon(@equipped_weapon) if @equipped_weapon.is_a? Grenade
    end
    other_robot.health
  end

  def attack!(enemy)
    raise UnattackableEnemy, "Cannot attack non-robots" unless enemy.is_a? Robot
  end

  def within_reach?(enemy)
    available_range = 1
    if @equipped_weapon.is_a? Grenade
      available_range = 2
    end
    (enemy.position[0]-@position[0]).abs <= available_range and (enemy.position[1]-@position[1]).abs <= available_range
  end

  def drop_weapon(item)
    @equipped_weapon = nil
    @items.delete(item)
  end
end
