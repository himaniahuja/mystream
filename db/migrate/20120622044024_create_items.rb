class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :category
      t.integer :confirmed_order_id, :default=>0
      t.string :title
      t.string :description
      t.string :location
      t.integer :condition
      t.integer :rental_price
      t.integer :deposit
      t.date :schedule_from
      t.date :schedule_to
      t.integer :expire
      t.has_attached_file :avatar

      t.timestamps
    end
  end
end
