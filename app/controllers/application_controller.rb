class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Exception, :with => :all_errors

  private

  def all_errors(error)
    render json: {errors: [error.message], backtrace: error.backtrace.grep(/controller/).first}, status: :bad_request
  end
end
