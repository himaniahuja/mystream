class Item < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user, :category, :title, :description, :location, :condition,
    :rental_price, :deposit, :schedule_from, :schedule_to
  validates_numericality_of :rental_price, :deposit
end
