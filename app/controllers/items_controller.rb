class ItemsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  
  def index
    @items = Item.all
	puts "himani"
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    @item.user = current_user
    
    if @item.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
	@item.user = current_user
  end

  # PUT /items/1
  def update
    @item = Item.find(params[:id])

	@item.user = current_user
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Successfully updated.') }
       else
        format.html { render :action => "edit" }
       end
    end
  end

  def myitems
	@items = Item.where(:user => current_user.id)

  end
end
