class OffersController < ApplicationController
  before_filter :require_user, :only => [:create]
  
  def create
    @offer = Offer.new(params[:offer])
    @offer.item = Item.find(params[:item_id])
    
    if @offer.save
      redirect_to :controller => "items", :action => "index"
    else
      @item = @offer.item
      render :template => 'items/show.html.erb'
    end
  end
  
end
