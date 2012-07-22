class CommentsController < ApplicationController
  before_filter :require_user

  def new

    @item = Item.find(params[:format])
    @receiver_id = @item.user_id
    @comment = Comment.new

  end

  def create

    @comment = Comment.new(params[:comment])
    @comment.item_id = params[:item_id]
    @comment.owner_id = current_user.id
    @comment.receiver_id = params[:receiver_id]

    if @comment.save
      redirect_to items_path
    else
      render :action => :new
    end
  end

  def index

    @comments = Comment.where(:receiver_id => params[:format]).order("created_at DESC")
    @comment_Hash = Hash.new

    @comments.each do |c|
      @sender = User.find(c.owner_id)
      @comment_Hash.store(c,@sender)
    end

  end

end
