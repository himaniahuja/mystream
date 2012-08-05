class ItemsController < ApplicationController
  before_filter :require_user, :only => [:new, :create, :edit, :update, :posted_items,
      :confirmed_items, :ordered]
  
  def index
    
    rank_by = "updated_at desc"
    if params[:rank_by]
      rank_by = params[:rank_by]
    end
    
    condition_keys = ['confirmed_order_id=?']
    condition_values = [0]

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
    
    if params[:category] and params[:category] != '0'
      condition_keys << "category=?"
      condition_values << params[:category]
    end
    
    conditions = [condition_keys.join(" AND ")] + condition_values
      
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
  
  def user_profile
    @user = User.find(params[:user_id])
  end
  
  def posted
    @items = Item.where(:user_id => current_user.id)
    render :template => 'items/items.html.erb'
  end
  
  def confirmed
    @items = Item.find(:all,
      :conditions => ['confirmed_order_id>0 and user_id=?', current_user.id]
    )
    render :template => 'items/items.html.erb'
  end
  
  def ordered
    @items = Item.find_by_sql(
      'select items.* from items, orders where items.confirmed_order_id=orders.id and orders.user_id='+current_user.id.to_s
    )    
    render :template => 'items/items.html.erb'
  end
  
end
