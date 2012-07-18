class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login,               :null => false
      t.string    :email,               :null => false
      t.string    :address,             :null => false
      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false
      t.string    :persistence_token,   :null => false

      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      t.timestamps
    end
    
    add_index :users, ["login"], :name => "index_users_on_login", :unique => true
    add_index :users, ["email"], :name => "index_users_on_email", :unique => true
    add_index :users, ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true
    
    User.create(
      :login => 'test1',
      :email => 'test1@gmail.com',
      :address => '330 Sierra Vista Ave Mountain View 94043',
      :password => '1234',
      :password_confirmation => '1234',
    )
    
    User.create(
      :login => 'test2',
      :email => 'test2@gmail.com',
      :address => '142 W Dana Street Mountain View 94041',
      :password => '1234',
      :password_confirmation => '1234',
    )
  end

  def self.down
    drop_table :users
  end
end
