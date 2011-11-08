require 'beanstalk-client'
require 'stalker'

tick_complete_stalk = Beanstalk::Pool.new(['localhost:11300'], 'turtle.tick.complete')

w = World.last
turtle_count = w.turtles.count

10.times do |clock|
  puts "Queueing ticks, time = #{clock}"
  Stalker.enqueue('world.tick', :world_id => w.id)
  turtle_count.times do
    job = tick_complete_stalk.reserve
    job.delete
  end
  puts "\tcompleted!"
end