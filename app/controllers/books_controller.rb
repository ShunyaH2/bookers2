class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_new_book, only: [:index, :my_books, :show]
  before_action :set_book,     only: [:show]
  before_action :set_own_book, only: [:edit, :update, :destroy]
  

  def index
    @books = Book
      .includes(user: { profile_image_attachment: :blob })
      .order(created_at: :desc)
    @user = current_user
    @new_book = Book.new
  end
    
  def show; 
    @user = @book.user
    @new_book = Book.new
  end
  
  def edit; end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was deleted."
  end
  
  def create
    @new_book = current_user.books.build(book_params)
    if @new_book.save
      redirect_to @new_book, notice: "You have created book successfully."
    else
      @books = Book.includes(user: { profile_image_attachment: :blob }).order(created_at: :desc)
      @user =current_user
      flash.now[:errors] = @new_book.errors.full_messages
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
  def set_new_book; @new_book = Book.new; end
  def set_book;     @book = Book.find(params[:id]); end
  def set_own_book
    @book = current_user.books.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: "権限がありません。"
  end
  def book_params;  params.require(:book).permit(:title, :body); end
end