class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :item_id
      t.integer :user_id
      t.date :rent_from
      t.date :rent_to

      t.timestamps
    end
  end
end
