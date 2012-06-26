class AddPhotosToItem < ActiveRecord::Migration
   def self.up
	add_attachment :items, :photo
  end

  def self.down
	remove_attachment :items, :photo
  end
end
