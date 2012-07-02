class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user
      t.integer :category
      t.string :title
      t.string :description
      t.string :location
      t.integer :condition
      t.integer :rental_price
      t.integer :deposit
      t.date :schedule_from
      t.date :schedule_to
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
