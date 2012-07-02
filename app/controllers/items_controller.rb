class ItemsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]

  def new
    @item = Item.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

   def show
	@item = Item.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end

  end

  def create
    @item = Item.new(params[:item])
	@item.user = current_user

	respond_to do |format|
       if @item.save
     	 format.html { redirect_to @item, notice: 'Item was successfully created.' }
       else
      	 format.html { render action: "new" }
       end
	end

  end
end