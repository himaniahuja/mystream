class ItemsController < ApplicationController
  before_filter :require_user, :only => [:index, :show, :new, :create, :edit, :update, :myitem]
  
  def index
    rank_by = "updated_at desc"
    if params[:rank_by]
      rank_by = params[:rank_by]
    end
    
    conditions = ['confirmed_order_id=0']
    if params[:myitems]
      conditions << ['user_id=?', current_user.id]
    end
      
    if rank_by == 'distance'
      @items = Item.find(:all,
        :conditions => conditions,
      ).sort!{|x, y|
        x.estimate_distance_val(current_user) <=> 
        y.estimate_distance_val(current_user)}
    else
      @items = Item.find(:all,
        :conditions => conditions,
        :order => rank_by
      )
    end
    
    # get all the confirmed items
    @confirmed_items = Item.find(:all,
      :conditions => ['confirmed_order_id>0 and user_id=?', current_user.id]
    )
  end
  
  def show
    @item = Item.find(params[:id])
    @order = Order.new
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
    if @item.user != current_user
      return
    end
    
    @item = Item.find(params[:id])
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
