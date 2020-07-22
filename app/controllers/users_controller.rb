class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
  	@user = User.find(current_user.id)
  	@book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = @user.books
  end

  def edit
  	@user = User.find(params[:id])
  	if current_user != @user
  	  redirect_to user_path(current_user)
  	end

  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	redirect_to user_path(@user.id)
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
