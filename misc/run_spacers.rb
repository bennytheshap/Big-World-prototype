def tick_till_happy(world_id)
  all_happy = false

  world = World.find world_id
  turtles = world.turtles

  counter = 0

  while not all_happy do
    counter += 1
    happy_count = 0
    turtles.each do |t|
      t.do_tick
      if t.happy?
        happy_count += 1
      end
    end
    all_happy = happy_count == turtles.count
    puts "Tick #{counter}: #{happy_count} turtles happy!"  
  end
end

tick_till_happy ARGV[0]