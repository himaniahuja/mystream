class User < ActiveRecord::Base
  acts_as_authentic

  acts_as_messageable

  has_many :items
  has_many :comments

  validates_presence_of :address
end
