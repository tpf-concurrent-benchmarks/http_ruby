class Poll < ApplicationRecord
    belongs_to :creator, class_name: "User"
    has_many :poll_options
    has_many :votes, through: :poll_options
end
