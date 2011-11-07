require 'spec_helper'

describe "A new patch" do
  
  before(:each) do
    @world = World.new
    @world.width = 40
    @world.height = 40
  end
  
  it "should take a world" do
    patch = Patch.new
    patch.world = @world
    patch.world.should == @world
  end
  
  it "should set x and y coordinates" do
    patch = Patch.new
    patch.world = @world
    
    patch.x = 10
    patch._x.should == 10
    patch.x.should == 10
    patch.location[:lng].should == 10
    
    patch.y = 20
    patch._y.should == 20
    patch.y.should == 20
    patch.location[:lat].should == 20
    
    patch.set_x_y(30,39)
    patch.x.should == 30
    patch.y.should == 39
  end
end