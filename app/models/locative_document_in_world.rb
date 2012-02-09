module LocativeDocumentInWorld
  extend ActiveSupport::Concern
  
  included do
    belongs_to :world, index: true

    field :_x, type: Integer
    field :_y, type: Integer
    field :location, type: Array, spacial: true

    index :_x
    index :_y
    index [[:location, Mongo::GEO2D], [:world_id, 1]],  {:min => 0, :max => 2000, :bits => 32} 
    
    shard_key :world, :_x, :_y

    validates_presence_of :world
    validates_presence_of :_x
    validates_presence_of :_y
    validates_presence_of :location

    validate :fits_in_world?

    def x
      self._x
    end

    def y
      self._y
    end

    def x=(new_x)
      set_x_y(new_x, self._y)
      self.x
    end

    def y=(new_y)
      set_x_y(self._x, new_y)
      self.y
    end
    
    def set_x_y(new_x, new_y)
      self._x = new_x
      self._y = new_y
      loc_list = [new_x, new_y]
      # self.location = {:lng => new_x, :lat => new_y}
      self.location = loc_list
      loc_list
    end

    def fits_in_world?
      errors.add(:_x, "must be less than world width") unless (_x < world.width)
      errors.add(:_y, "must be less than world height") unless (_y < world.height)
    end
    
    def turtles_in_radius(radius)
      Turtle.where(:world_id => world.id, :_id.ne => self.id).geo_near([x, y], :max_distance => radius)
    end
    
    def turtles_of_species_in_radius(species, radius)
      Turtle.excludes(:_id => self.id).where(:world_id => world.id, :_type => species).geo_near([x, y], :max_distance => radius)
    end
    
    def patches_in_radius(radius)
      Patch.where(:world_id => world.id, :_id.ne => self.id).geo_near([x, y], :max_distance => radius)
    end
    
    
    def save_with_reshard
      if _x_changed? or _y_changed?
        new_turtle = self.clone
        new_turtle._id = self.id
        self.destroy
        new_turtle.save
      else
        save
      end
    end

    def save_with_reshard!
      if _x_changed? or _y_changed?
        new_turtle = self.clone
        new_turtle._id = self.id
        self.destroy
        new_turtle.save!
      else
        save!
      end
    end
    
  end
end
