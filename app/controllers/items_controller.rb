class ItemsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]

  def new
    @item = Item.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def create
    @item = Item.new(params[:item])
    @item.user = current_user
    
    if @item.save
      # redirect
    else
      render :action => :new
    end
  end
end
