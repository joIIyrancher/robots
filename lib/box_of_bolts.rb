BOX_OF_BOLTS_NAME = "Box of bolts"
BOX_OF_BOLTS_WEIGHT = 25

class BoxOfBolts < Item
  def initialize
    super(BOX_OF_BOLTS_NAME, BOX_OF_BOLTS_WEIGHT)
  end

  def feed(robot)
    robot.heal(points=20)
  end
end