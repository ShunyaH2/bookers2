class BooksController < ApplicationController
  def show
  end

  def edit
  end

  def index
    @books = Book.all
  end

  def my_books
    @books = current_user.books
    render :index
  end
end
