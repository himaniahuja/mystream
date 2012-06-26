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
	@item.user = current_user.id

	respond_to do |format|
       if @item.save
     	 format.html { redirect_to @item, notice: 'Item was successfully created.' }
      	 #format.json { render json: @user, status: :created, location: @user}
       else
      	 format.html { render action: "new" }
      	 #format.json { render json: @user.errors, status: :unprocessable_entity }
       end
	end

	#format.html { redirect_to @user, notice: 'Blob was successfully created.' }
	#if @item.save
    #  format.html { redirect_to item_path(@item)}
    #else
    #  render :action => :new
    #end
  end
end