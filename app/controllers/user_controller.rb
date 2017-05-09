class UserController < ApplicationController
  skip_before_action :authorize, only: [:index, :create, :update, :delete]
  require 'json'
  def new
  end
  #GET /users
  def index
	@users = User.all
	render :json => @users
	#respond_to do |format|
		#format.html do
		#	redirect_to '/dashboard'
		#end
		#format.json {render json: @users}
	#end
  end
  #GET user/id
  def show
	@user = User.find(params[:id])
	render :json => @user
  end
  
   
  #POST /user
  def create
	@user = User.new(user_params)
	
	if @user.save
		@response = {:status => "201", :message => "User successfully created."}
		render :json => @response
	else
		render :json => @user.errors
	end
  end
  
  def user_params
	params.permit(:email, :password)
  end
  
  #PUT /user/id
  def update
	@user = User.find(params[:id])
	
	if @user.update_attributes(user_param)
		@response = { :message => "User successfully updated." }
		render :json => @response
	else
		render :json => @user.errors
	end
  end
  
   def user_param
	params.permit(:email, :password)
   end
  
  #DELETE /user/id
  def delete
	User.find(params[:id]).destroy
	
	@response = { :message => "User successfully deleted." }
	render :json => @response
  end 
end
