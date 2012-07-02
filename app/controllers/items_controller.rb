class ItemsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
<<<<<<< HEAD
	@item.user = current_user

	respond_to do |format|
       if @item.save
     	 format.html { redirect_to @item, notice: 'Item was successfully created.' }
       else
      	 format.html { render action: "new" }
       end
	end

=======
    @item.user = current_user
    
    if @item.save
      redirect_to :action => :index
    else
      render :action => :new
    end
>>>>>>> fc176ba02a42b363a02d5a992f337cc101a468a9
  end
end
