class Item < ActiveRecord::Base
  belongs_to :user,  :foreign_key => :user, :class_name => "User"
  validates_presence_of :user, :category, :title, :description, :location, :condition,
    :rental_price, :deposit, :schedule_from, :schedule_to
  validates_numericality_of :rental_price, :deposit
  has_attached_file :avatar, :styles => { :thumb => "100x100>" }
  
  validate :from_should_be_smaller_than_to
  
  def from_should_be_smaller_than_to
    if schedule_from > schedule_to
      errors.add(:schedule_from, "End Date can't be earlier than State Date")
    end
  end
end
