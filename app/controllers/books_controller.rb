class BooksController < ApplicationController
  before_action :set_new_book, only: [:index, :my_books, :show]
  
  def show
  end

  def edit
  end

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      @books = Book.all 
      render :index
    end
  end

  def my_books
    @books = current_user.books
    render :index
  end
  private

  def set_new_book
    @book = Book.new
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
