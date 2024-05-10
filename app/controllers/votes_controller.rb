class VotesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def create
        p = vote_params
        if Vote.exists?(user_id: p[:user_id], poll_id: p[:poll_id])
            update(p)
        else
            @vote = Vote.create!(p)
            render json: @vote, status: :created
        end
    end

    def update(p)
        @vote = Vote.find_by(user_id: p[:user_id], poll_id: p[:poll_id])
        if @vote.option_num == p[:option_num]
            @vote.destroy
            render json: { message: "Vote removed" }, status: :ok
        else
            @vote.update!(option_num: p[:option_num])
            render json: @vote, status: :ok
        end
    end

    private

    def vote_params
        params.permit(:poll_id).merge(user_id: current_user.id).merge(request.query_parameters).tap do |p|
            p[:option_num] = p.delete(:option).to_i
        end
    end

    def handle_invalid_record(e)
        render json: { error: e.message }, status: :unprocessable_entity
    end

    def handle_not_found(e)
        render json: { error: e.message }, status: :not_found
    end
end
