class User < ActiveRecord::Base
  acts_as_authentic

  acts_as_messageable

  has_many :items
  has_many :comments

  validates_presence_of :address
  
  def get_state
    guess = []
    components = Gmaps4rails.geocode(address)[0][:full_data]["address_components"]
    components.each do |component|
      if component["types"].include? 'political'
        guess << component["long_name"]
      end
    end
    return guess.join(" , ")
  end

  def average_rating
    comments = Comment.find(:all, :conditions=>['receiver_id=?', self.id])
     
    sum = 0
    comments.each do |comment|
      sum += comment.rating
    end
    if comments.length == 0
      return "N/A"
    else
      return sprintf("%0.1f", "#{sum.to_f/comments.length}")
    end
  end
  
end
