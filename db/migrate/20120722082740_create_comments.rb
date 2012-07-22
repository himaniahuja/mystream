class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :item_id
      t.integer :owner_id
      t.integer :receiver_id
      t.integer :rating
      t.text :comment_text

      t.timestamps
    end
  end
end
