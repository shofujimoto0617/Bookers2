class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
  	@books = Book.all
  	@book = Book.new
  	@user = User.find(current_user.id)
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  	  flash[:notice] = "You have creatad book successfully."
  	  redirect_to book_path(@book.id)
  	else
      @user = User.find(current_user.id)
      @books = Book.all
  	  render :index
  	end

  end

  def show
  	@book = Book.find(params[:id])
  	@user = @book.user
  end

  def edit
  	@book = Book.find(params[:id])
  	if current_user != @book.user
  	  redirect_to books_path
  	end

  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	  flash[:notice] = "You have updated book successfully."
  	  redirect_to book_path(@book)
  	else
  	  render :edit
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
