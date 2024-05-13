class PollsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]

    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from Exception, with: :handle_generic_error

    def index 
        @polls = Poll.all
        render json: {polls: @polls}, each_serializer: SimplePollSerializer, status: :ok
    end

    def show 
        @poll = Poll.find(params[:id])
        render json: @poll, serializer: FullPollSerializer, status: :ok
    end

    def create 
        @poll = Poll.create!(poll_params)
        render json: @poll, status: :created
    end

    def destroy
        @poll = Poll.find(params[:id])
        @poll.destroy!(current_user)
        render json: { message: "Poll deleted" }, status: :ok
    end

    private

    def poll_params 
        params.merge(creator_id: current_user.id)
    end

    def handle_invalid_record(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def handle_not_found(e)
        render json: { error: e.message }, status: :not_found
    end    

    def handle_generic_error(e)
        render json: { error: e.message }, status: :bad_request
    end
end