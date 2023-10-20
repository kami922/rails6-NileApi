class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotDestroyed , with: :not_destroyed

  private
  def not_destroyed(err)
      render json: {errors: err.record.errors }, status: :unprocessable_entity
  end
end
