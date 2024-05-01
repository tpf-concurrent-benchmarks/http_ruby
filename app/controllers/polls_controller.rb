class PollsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

    def index 
        @polls = Poll.all
        render json: @polls, each_serializer: SimplePollSerializer, status: :ok
    end

    def show 
        @poll = Poll.find(params[:id])
        render json: @poll, serializer: FullPollSerializer, status: :ok
    end

    def create 
        p = poll_params
        puts "Poll params: #{p}"
        @poll = Poll.build(poll_topic: p["poll_topic"], creator_id: p["creator_id"])
        p["options"].each do |option|
            puts "Option: #{option}"
            @poll.poll_options.build(option_text: option)
        end
        @poll.save!

        render json: @poll, status: :created
    end

    private

    def poll_params 
        params.merge(creator_id: current_user.id)
    end

    def handle_invalid_record(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def handle_not_found
        render json: { message: "Poll not found" }, status: :not_found
    end    
end