class Item < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user"
  validates_presence_of :user, :category, :title, :description, :location, :condition,
    :rental_price, :deposit, :schedule_from, :schedule_to
  validates_numericality_of :rental_price, :deposit

  # Paperclip
	has_attached_file :photo,
  		:styles => {
   		:thumb=> "100x100#",
    	:small  => "150x150>",
    	:medium => "300x300>",
    	:large =>   "400x400>" }

  		# in order to store pictures on the app.
        #http://railscasts.com/episodes/134-paperclip
  		#:url  => "/items/:id/:style/:basename.:extension",
		#:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  	#validates_attachment_presence :photo
	#validates_attachment_size :photo, :less_than => 5.megabytes
	#validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']



end
