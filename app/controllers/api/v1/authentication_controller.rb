module Api
  module V1
    class AuthenticationController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :param_missing
      def create
        # puts params.inspect
        p params.require(:password).inspect
        user = User.find_by(username: params.require(:username))
        token = AuthenticationTokenService.call(user.id)
        render json:{ token:token}, status: :created
      end

      private
      def param_missing(e)
        render json: { error: e.message },status: :unprocessable_entity
      end

    end
  end
end

# curl -X POST http://localhost:3000/api/v1/authenticate -H "Content-Type: application/json" -d '{"username": "BookSeller69","password":"blah"}'
