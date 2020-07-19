class BooksController < ApplicationController

  def index
  	@books = Book.all
  	@book = Book.new
  	@user = User.find(current_user.id)
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	@book.save
  	redirect_to books_path
  end

  def show
  	@book = Book.find(params[:id])
  	@user = User.find(current_user.id)
  	@book = Book.new
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
