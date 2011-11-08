require File.expand_path("../../../config/environment", __FILE__)
require 'beanstalk-client'
require 'stalker'
include Stalker

tick_complete_stalk = Beanstalk::Pool.new(['localhost:11300'], 'turtle.tick.complete')


job 'world.tick' do |args|
  world = World.find args["world_id"]
  world.turtles.each do |turtle|
    enqueue('turtle.tick', :turtle_id => turtle.id)
  end
end

job 'turtle.tick' do |args|
  turtle = Turtle.find args["turtle_id"]
  turtle.do_tick
  tick_complete_stalk.put(turtle.id)
end