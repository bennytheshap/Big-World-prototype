class World
  include Mongoid::Document

  field :width, type: Integer
  field :height, type: Integer
  
  has_many :patches
  #has_many :turtles
  
  def initialize_patches
    if not (width and height)
      raise "Cannot initialize without a width and a height!"
    else
      width.times do |x|
        height.times do |y|
          p = Patch.new
          p.world = self
          p.set_x_y(x,y)
          p.save!
        end
      end
    end
  end
  
end