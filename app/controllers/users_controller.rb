class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:index, :show, :edit, :update,
    :inbox, :outbox, :sendMessage, :createMessage, :showMessage, 
    :showSentMessage, :replyMessage, :createReplyMessage, :deleteMessage, :dashboard]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save
      flash[:notice] = "Your account has been created."
      redirect_to :action => :index
    else
      flash[:notice] = "There was a problem creating you."
      render :action => :new
    end
  end

  def index
    # @user = User.find(params[:id])
    @user = current_user
  end


  def show
    @user = current_user
    render :template=>'users/index.html'
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id]) # makes our views "cleaner" and more consistent

    if @user.update_attributes(params[:user])
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def dashboard
    messages = current_user.received_messages
    @numberOfUnreadMessages = 0
    messages.each do |m|
      if !m.recipient_delete
        if !m.opened
          @numberOfUnreadMessages += 1
        end
      end
    end
  end

  def inbox
    @title = "Inbox"
    @messages = current_user.received_messages

    @messagesHash = Hash.new
    @messagesRead = Array.new
    @messagesUnread = Array.new
    @numberOfUnreadMessages = 0

    @messages.each do |m|
      if !m.recipient_delete
        if !m.opened
          @messagesUnread << m
          @numberOfUnreadMessages +=1
        else
          @messagesRead << m
        end
      end
      @messagesHash.store(m.id, User.find(m.sent_messageable_id).login)
    end

  end

  def outbox
    @title = "Outbox"
    @messages_all = current_user.sent_messages
    @messagesHash = Hash.new
    @messages = Array.new

    @messages_all.each do |m|
      if !m.sender_delete
        @messages << m
      end
    end

    @messages.each do |m|
      @receiver = User.find(m.received_messageable_id)
      @messagesHash.store(m.id, @receiver.login)
    end

  end

  def sendMessage
    @item = Item.find(params[:format])
    @recipient_id = @item.user.id
    @message = ActsAsMessageable::Message.new
    @topic = "Hi! I am interested in the " + @item.title + " you posted about. "

  end

  def createMessage

    @to = User.find(params[:acts_as_messageable_message][:recipient].to_i)

    current_user.
        send_message(@to, params[:acts_as_messageable_message][:topic], params[:acts_as_messageable_message][:body])

    flash[:notice] = 'Message was successfully sent.'
    redirect_to items_path(@item)

  end

  def showMessage

    @message = current_user.messages.with_id(params[:id]).first
    @sender = User.find(@message.sent_messageable_id)
    @body = @message.body
    @bodyTexts = @body.split("-----")
    @message.mark_as_read
    @message.save!

  end

  def showSentMessage

    @message = current_user.messages.with_id(params[:id]).first
    @body = @message.body
    @bodyTexts = @body.split("-----")
    @receiver = User.find(@message.received_messageable_id)

  end

  def replyMessage

    @message = current_user.messages.with_id(params[:id]).first
    @recipient_id = @message.sent_messageable_id
    @recipient = User.find(@recipient_id)

    @topic = "Re: #{@message.topic}"
    @body = "\n\n\n\n\n\n--------------------------------------------\n\nOn " +
        @message.created_at.strftime("%B %d %Y (%a)") + " " +
        @recipient.login + " wrote :  \n " + @message.body

  end


  def createReplyMessage

    @message = current_user.messages.with_id(params[:id]).first
    @body = params[:acts_as_messageable_message][:body]
    #@new_body = @body.split("--------")[0]
    current_user.reply_to(@message, "Re: #{params[:acts_as_messageable_message][:topic]}", @body)

    flash[:notice] = 'Reply sent.'
    redirect_to inbox_path

  end

  def deleteMessage

    @message = current_user.messages.with_id(params[:id]).first

    if current_user.id == @message.received_messageable_id
      @message.recipient_delete = true
      @message.save!
      flash[:notice] = 'Message deleted.'
      redirect_to inbox_path

    elsif current_user.id == @message.sent_messageable_id
      @message.sender_delete = true
      @message.save!
      flash[:notice] = 'Message deleted.'
      redirect_to outbox_path

    end

  end

  def deleteAllMessages
    if params[:format] == "inbox"
      @messages = current_user.received_messages
      @messages.each do |m|
        m.recipient_delete = true
        m.save!
      end
    else
      @messages = current_user.sent_messages
      @messages.each do |m|
        m.sender_delete = true
        m.save!
      end
    end

    flash[:notice] = 'Messages deleted.'
    redirect_to items_path

  end

end
