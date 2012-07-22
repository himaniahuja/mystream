class Comment < ActiveRecord::Base
  belongs_to :user, :foreign_key => "receiver_id"
  belongs_to :item, :foreign_key => "item_id"
end
