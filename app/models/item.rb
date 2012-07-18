class Item < ActiveRecord::Base
  belongs_to :confirmed_order,   :class_name => "Order"
  
  belongs_to :user
  has_many :orders
  validates_presence_of :user, :category, :title, :description, :location, :condition,
    :rental_price, :deposit, :schedule_from, :schedule_to
  validates_numericality_of :rental_price, :deposit
  has_attached_file :avatar, :styles => { :thumb => "100x100>" }
  
  validate :from_should_be_smaller_than_to
  
  def from_should_be_smaller_than_to
    if not schedule_from.nil? and not schedule_to.nil? and schedule_from > schedule_to
      errors.add(:schedule_from, "End Date can't be earlier than State Date")
    end
  end
  
  # estimate the distance from current user to location
  def estimate_distance_val(user)
    return estimate_distance(user)['value']
  end
  
  def estimate_distance_text(user)
    return estimate_distance(user)['text']
  end
  
 private
  def estimate_distance(user)
    from = user.address
    to = location
    
    # fetch from cache
    gmap = Gmap.where(:from => from, :to => to)
    if not gmap.empty?
      return Marshal.load(gmap[0].distance)
    end
    
    # TODO we need to catch exceptions herer
    directions = Gmaps4rails.destination({
      'from' => from,
      'to' => to,
    })
    result = directions.first['distance']
    # store in cache
    Gmap.create(
      :from => from,
      :to => to,
      :distance => Marshal.dump(result) 
    )
    return result
  end
end
