describe World do
  it "should accept a width and a height" do
    world = World.new
    world.width = 40
    world.height = 40
    world.width.should be 40
    world.height.should be 40
  end
  
  it "should initialize its patches" do
    world = World.new
    world.width = 40
    world.height = 40
    world.save!
    
    lambda {world.initialize_patches}.should_not raise_error
    world.patches.count.should == world.width * world.height
  end
end