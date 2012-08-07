class CommentsController < ApplicationController
  before_filter :require_user

  def new

    @item = Item.find(params[:format])

    @can_write = false
    if @item.confirmed_order
        @confirmed_order =  @item.confirmed_order
        @sender = @confirmed_order.user
        @comments = Comment.where(:item_id => @item, :owner_id => current_user.id).first

        if (@sender  == current_user || @item.user == current_user) && !@comments
          @can_write = true
        end
    end

    @receiver_id = @item.user_id
    @comment = Comment.new

  end

  def create

    @comment = Comment.new(params[:comment])
    @comment.item_id = params[:item_id]
    @comment.owner_id = current_user.id
    @item = Item.find(params[:item_id])

    if current_user == @item.user
       @comment.receiver_id = @item.confirmed_order.user.id
    else
       @comment.receiver_id = @item.user
    end

    #@comment.receiver_id = params[:receiver_id]

    if @comment.save
      redirect_to items_path
    else
      render :action => :new
    end
  end

  def index
    @receiver_id = params[:format]
    @receiver = User.find(@receiver_id)
    @comments = Comment.where(:receiver_id => @receiver_id).order("created_at DESC")
    @comment_Hash = Hash.new

    @comments.each do |c|
      @sender = User.find(c.owner_id)
      @comment_Hash.store(c,@sender)
    end

  end

end
