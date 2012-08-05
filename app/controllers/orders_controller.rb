class OrdersController < ApplicationController
  before_filter :require_user, :only => [:create, :confirm]
  
  def create
    @order = Order.new(params[:order])
    @order.item = Item.find(params[:item_id])
    @order.user = current_user
    
    if @order.save
      redirect_to :controller => "items", :action => "index"
    else
      @item = @order.item
      render :template => 'items/show.html.erb'
    end
  end
  
  def confirm
    @order = Order.find(params[:id])
    @item = @order.item
    
    # send messages to all users
    for order in @item.orders
      msg_from = @item.user
      if order == @order
        title = "Confirmed order"
        msg = "Thank you for your order. Please contact me for further information."
      else
        title = "We are sorry..."
        msg = "We are sorry to inform you that the item is not available. Please browse other items."
      end
      msg_from.send_message(order.user, 
        title,
        msg)
    end
    
    @item.confirmed_order = @order
    @item.save
    redirect_to :controller => "items", :action => "index"
  end
  
end
