class Patch
  include Mongoid::Document
  include Mongoid::Spacial::Document
  include LocativeDocumentInWorld
  
  validates_uniqueness_of :_x, :scope => [:_y, :world_id]
  validates_uniqueness_of :_y, :scope => [:_x, :world_id]
  
  def self.new_in_world_at_x_y(world, x, y)
    p = Patch.new
    p.world = world
    p.x = x
    p.y = y
    
    p
  end
  
end