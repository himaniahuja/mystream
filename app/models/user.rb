class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_messageable

  has_many :items
  validates_presence_of :address
end
