module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError;end
    rescue_from ActionController::ParameterMissing, with: :param_missing
    rescue_from AuthenticationError, with: :handle_unauthenticated
      def create
        # puts params.inspect
        p params.require(:password).inspect
        user = User.find_by(username: params.require(:username))
        raise AuthenticationError unless user.authenticate(params.require(:password))
        token = AuthenticationTokenService.call(user.id)
        render json:{ token:token}, status: :created
      end

      private
      def param_missing(e)
        render json: { error: e.message },status: :unprocessable_entity
      end

      def handle_unauthenticated
        head :unauthorized
      end

    end
  end
end

# curl -X POST http://localhost:3000/api/v1/authenticate -H "Content-Type: application/json" -d '{"username": "BookSeller69","password":"blah"}'
