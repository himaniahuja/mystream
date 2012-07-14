class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :item
      t.date :rent_from
      t.date :rent_to

      t.timestamps
    end
  end
end
