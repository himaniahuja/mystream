class AddInterestsToUsers < ActiveRecord::Migration
  def self.up
      add_column :users, :interests, :string
  end

  def self.down
      remove_column :users, :interests, :string
  end
end
