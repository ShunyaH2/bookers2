class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_new_book, only: [:index, :my_books, :show]
  before_action :set_book,     only: [:show]
  before_action :set_own_book, only: [:edit, :update, :destroy]

  def index
    @books = Book
      .includes(user: { profile_image_attachment: :blob })
      .order(created_at: :desc)
  end

  def show; end
  def edit; end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "You have updated book successfully."
    else
      flash.now[:alert] = "Failed to update book."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was deleted."
  end
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: "You have created book successfully."
    else
      # 失敗時は index を再表示できるように一覧を用意
      @books = Book.includes(user: { profile_image_attachment: :blob }).order(created_at: :desc)
      flash.now[:alert] = "Failed to create book."
      render :index, status: :unprocessable_entity
    end
  end
  
  def my_books
    @books = current_user.books
              .includes(user: { profile_image_attachment: :blob })
              .order(created_at: :desc)
    render :index
  end

  private
  def set_new_book; @book = Book.new; end
  def set_book;     @book = Book.find(params[:id]); end
  def set_own_book; @book = current_user.books.find(params[:id]); end
  def book_params;  params.require(:book).permit(:title, :body); end
end