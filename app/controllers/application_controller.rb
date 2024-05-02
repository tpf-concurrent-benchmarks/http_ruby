class ApplicationController < ActionController::API
    before_action :authorized

    def initialize
        @secret_key = ENV['SECRET_KEY']
        @algorithm = ENV['ALGORITHM']
        @exp = ENV['ACCESS_TOKEN_EXPIRE_MINUTES'].to_i.minutes
        super
    end

    def encode_token(payload)
        payload[:exp] = @exp.minutes.from_now.to_i
        JWT.encode(payload, @secret_key, @algorithm)
    end

    def decoded_token
        header = request.headers['Authorization']
        if header
            token = header.split(" ")[1]
            begin
                JWT.decode(token, @secret_key, true, algorithm: @algorithm)
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        payload = decoded_token
        if payload.nil?
            return nil
        end
        if check_expired(payload)
            user_id = payload[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def check_expired(payload)
        puts "Payload: #{payload}"
        exp = payload[0]['exp']
        return !exp.nil? && Time.at(exp) >= Time.now
    end

    def authorized
        unless !!current_user
            render json: { message: 'Please log in' }, status: :unauthorized
        end
    end

end