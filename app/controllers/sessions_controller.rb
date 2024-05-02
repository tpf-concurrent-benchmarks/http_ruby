class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordNotFound, with: :handle_invalid_username_or_password

    def create
        @user = User.find_by!(username: login_params[:username])
        if @user.authenticate(login_params[:password])
            @token = encode_token({:user_id => @user.id})
            render plain: @token, status: :ok
        else
            handle_invalid_username_or_password
        end

    end

    private 

    def login_params 
        params.permit(:username, :password)
    end

    def handle_invalid_username_or_password
        render json: { message: "Username or password is incorrect" }, status: :not_found
    end
end