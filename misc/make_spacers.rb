w = World.new 
w.width = 100
w.height = 100
w.save!

w.initialize_patches

80.times do 
  t = SpacerTurtle.new
  t.world = w
  t.x = rand(w.width)
  t.y = rand(w.height)
  t.heading = rand(360)
  t.save!
end

puts "World id = #{w.id}"