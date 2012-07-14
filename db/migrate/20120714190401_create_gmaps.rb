class CreateGmaps < ActiveRecord::Migration
  def change
    create_table :gmaps do |t|
      t.string :from
      t.string :to
      t.string :distance

      t.timestamps
    end
  end
end
