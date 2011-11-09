class SpacerTurtle < Turtle
  def tick
    if not happy?
      wiggle
    end
  end
  
  def happy?
    neighbors = turtles_of_species_in_radius(:SpacerTurtle, 3)
    neighbors.count == 0
  end
  
  def wiggle
    turn_right rand(20)
    forward 3
  end
end