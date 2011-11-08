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
  
  it "should be initializable with world, x, and y" do
    patch = Patch.new_in_world_at_x_y(@world, 10, 20)

    patch._x.should == 10
    patch.x.should == 10
    patch.location[:lng].should == 10
    
    patch._y.should == 20
    patch.y.should == 20
    patch.location[:lat].should == 20
  end
end