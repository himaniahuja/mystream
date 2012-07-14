class Offer < ActiveRecord::Base
  belongs_to :item
  validates_presence_of :item, :rent_from, :rent_to
  
  validate :from_should_be_smaller_than_to
  
  def from_should_be_smaller_than_to
    if not rent_from.nil? and not rent_to.nil? and not item.nil?
      if rent_from < item.schedule_from or rent_to > item.schedule_to
        errors.add(:schedule_from, "Offer range is not in item time range")
      end
    end
  end
  
end
