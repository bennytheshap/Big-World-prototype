w = World.new 
w.width = 40
w.height = 40
w.save!

w.initialize_patches

1000.times do 
  t = CirclerTurtle.new
  t.world = w
  t.x = rand(w.width)
  t.y = rand(w.height)
  t.heading = rand(360)
  t.save!
end

puts "World id = #{w.id}"