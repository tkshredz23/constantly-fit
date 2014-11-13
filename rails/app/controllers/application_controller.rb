class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  helper_method :current_user_authorized?

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  # def after_sign_in_path_for(resource)
  #   redirect_to root_url
  # end

  def authorize_user
    unless current_user_authorized?
      redirect_to new_user_session_path
    end
  end

  def current_user_authorized?
    params[:user_id].present? &&
      current_user &&
      current_user.id == params[:user_id].to_i
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end
end
