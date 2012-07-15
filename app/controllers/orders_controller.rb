class OrdersController < ApplicationController
  before_filter :require_user, :only => [:create]
  
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
    @item.confirmed_order = @order
    
    @item.save
    redirect_to :controller => "items", :action => "index"
  end
  
end
