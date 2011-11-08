require 'spec_helper'

describe "A new turtle" do
  
  before(:each) do
    @world = World.new
    @world.width = 40
    @world.height = 40
  end
  
  it "should take a world" do
    turtle = Turtle.new
    turtle.world = @world
    turtle.world.should == @world
  end
  
  it "should be able to set x and y coordinates" do
    turtle = Turtle.new
    turtle.world = @world
    
    turtle.x = 10
    turtle._x.should == 10
    turtle.x.should == 10
    turtle.location[:lng].should == 10
    
    turtle.y = 20
    turtle._y.should == 20
    turtle.y.should == 20
    turtle.location[:lat].should == 20
    
    turtle.set_x_y(30,39)
    turtle.x.should == 30
    turtle.y.should == 39
  end
  
  it "should be able to set a heading" do
    turtle = Turtle.new
    turtle.world = @world
    turtle.heading = 90
    
    turtle.heading.should == 90
  end
  
  it "should be able to step forward" do
    turtle = Turtle.new
    turtle.world = @world
    turtle.x = 10
    turtle.y = 10
    turtle.heading = 0
    lambda {turtle.forward 10}.should_not raise_error
    turtle.x.should == 20
    turtle.y.should == 10
  end
end