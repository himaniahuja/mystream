class User < ActiveRecord::Base
  acts_as_authentic

  has_many :items
  validates_presence_of :address
end
