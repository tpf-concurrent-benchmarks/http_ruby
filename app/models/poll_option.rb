class PollOption < ApplicationRecord
    belongs_to :poll
    has_many :votes

    validates :option_text, presence: true
end
