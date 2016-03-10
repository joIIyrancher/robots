BOX_OF_BOLTS_NAME = "Box of bolts"
BOX_OF_BOLTS_WEIGHT = 25

class BoxOfBolts < Item
  attr_reader :heal_points
  def initialize
    super(BOX_OF_BOLTS_NAME, BOX_OF_BOLTS_WEIGHT)
    @heal_points = 20
  end

  def feed(robot)
    robot.heal(heal_points)
  end
end