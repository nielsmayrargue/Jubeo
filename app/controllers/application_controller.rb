class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:error] = "Vous n'êtes pas autorisés à effectuer cette action."
    redirect_to request.headers["Referer"] || root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:full_name, :is_a_coach, :avatar, :email, :password, :password_confirmation, :phone_number)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:avatar, :bio, :is_a_coach, :full_name, :email, :password, :password_confirmation, :phone_number)
    end

  end

end
