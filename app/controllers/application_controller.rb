class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    # For now, simply return the first user from the database.
    @current_user ||= User.first
  end
end
