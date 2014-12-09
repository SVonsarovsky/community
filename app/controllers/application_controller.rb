class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  #rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def current_user
    #@current_user ||= User.find_by_id(session[:user])
    @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def logged_in?
    current_user != nil
  end

  def default_url_options # /posts/new -> /posts/new?locale=en
    { locale: I18n.locale }
  end

  def record_not_found
    render text: '404 Not Found', status: 404
  end
end
