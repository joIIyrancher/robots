LASER_NAME = "Laser"
LASER_WEIGHT = 125
LASER_DAMAGE = 25

class Laser < Weapon
  attr_reader :range

  def initialize
    super(LASER_NAME, LASER_WEIGHT, LASER_DAMAGE)
    @range = 1
  end
end