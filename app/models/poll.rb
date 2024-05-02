class Poll < ApplicationRecord
    belongs_to :creator, class_name: "User"
    has_many :poll_options

    def yay
        puts "Yay!"
    end

    def self.create!(params)
        check_options(params)
        i = 0
        @poll = Poll.build(poll_topic: params[:poll_topic], creator_id: params[:creator_id])
        params[:options].each do |option|
            @poll.poll_options.build(option_num: i, option_text: option)
            i += 1
        end
        @poll.save!
        @poll
    end

    private
    def self.check_options(params)
        if params[:options].nil?
            raise Exception.new("Options cannot be nil")
        end
        if params[:options].length < 2
            raise Exception.new("Poll must have at least 2 options")
        end
    end
end