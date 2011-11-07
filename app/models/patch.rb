class Patch
  include Mongoid::Document
  include Mongoid::Spacial::Document

  belongs_to :world, index: true

  field :_x, type: Integer
  field :_y, type: Integer
  field :location, type: Array, spacial: true
  

  index :_x
  index :_y
  spacial_index :location

  validates_presence_of :world
  validates_presence_of :_x
  validates_presence_of :_y
  validates_presence_of :location
  
  validates_uniqueness_of :_x, :scope => [:_y, :world_id]
  validates_uniqueness_of :_y, :scope => [:_x, :world_id]

  validate :fits_in_world
  
  def x
    _x
  end
  
  def y
    _y
  end
  
  def x=(new_x)
    set_x_y(new_x, y)
  end
  
  def y=(new_y)
    set_x_y(x, new_y)
  end
  
  def set_x_y(new_x, new_y)
    self._x = new_x
    self._y = new_y
    self.location = {:lng => new_x, :lat => new_y}
  end
  
  def fits_in_world
    errors.add(:_x, "must be less than world width") unless (_x < world.width)
    errors.add(:_y, "must be less than world height") unless (_y < world.height)
  end
  
end