# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ishare::Application.initialize!

# start a new thread
Thread.new {
  while 1
    Item.all.each do |item|
      if Time.now > item.created_at + item.expire * 60
        # send messages to all people who placed an order
        title = "We are sorry..."
        msg = "We are sorry to inform you that the item you ordered is expired. "
        msg2 = "We are sorry to inform you that the item you posted is expired. "

        for order in item.orders
          item.user.send_message(order.user, 
            title,
            msg)
        end
        
        # send messages to owner
        item.user.send_message(item.user,
            title,
            msg2)
            
        item.delete
      end
    end
    sleep 5 # sleep 5 seconds
  end
}