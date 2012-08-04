class ItemsController < ApplicationController
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  
  def index
    
    rank_by = "updated_at desc"
    if params[:rank_by]
      rank_by = params[:rank_by]
    end
    
    condition_keys = ['confirmed_order_id=?']
    condition_values = [0]

    if params[:myitems]
      if not require_user
        return
      end
      condition_keys << 'user_id=?'
      condition_values << current_user.id
    end
    
    if params[:search] and params[:search][:title]
      condition_keys << 'title LIKE ?'
      condition_values << '%'+params[:search][:title]+'%'
    end
    
    if params[:search] and params[:search][:category]
      condition_keys << 'category LIKE ?'
      condition_values << '%'+params[:search][:category]+'%'
    end
    
    if params[:search] and not params[:search][:to].empty?
      condition_keys << "rental_price<=?"
      condition_values << params[:search][:to]
    end
    
    if params[:search] and not params[:search][:from].empty?
      condition_keys << "rental_price>=?"
      condition_values << params[:search][:from]
    end
    
    conditions = [condition_keys.join(" AND ")] + condition_values
    puts '2' * 100
    puts conditions
    puts '1' * 100
      
    if rank_by == 'distance'
      if not require_user
        return
      end
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
    @item = Item.find(params[:id])

    if @item.user != current_user
      return
    end
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

  def user_profile
    @user = User.find(params[:user_id])
  end
  
end
