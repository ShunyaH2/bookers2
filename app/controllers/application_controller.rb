class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_sidebar_book, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  def after_sign_in_path_for(resource)
    my_books_books_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private
  def prepare_sidebar_book
    @book ||= Book.new
  end

end
