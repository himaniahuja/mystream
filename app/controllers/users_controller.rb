class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
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
      redirect_to signup_url
    else
      flash[:notice] = "There was a problem creating you."
      render :action => :new
    end    
  end

  def show
    # @user = User.find(params[:id])
    @user = current_user
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # PUT /users/1
  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      format.html {redirect_to(@user, :notice => 'Successfully updated.') }
    else
      format.html { render :action => :edit }
    end
  end
end