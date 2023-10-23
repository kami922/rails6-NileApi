module Api
  module V1
    class AuthenticationController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :param_missing
      def create
        # puts params.inspect
        p params.require(:username).inspect
        p params.require(:password).inspect
        render json:{ token:'123'}, status: :created
      end

      private
      def param_missing(e)
        render json: { error: e.message },status: :unprocessable_entity
      end

    end
  end
end
