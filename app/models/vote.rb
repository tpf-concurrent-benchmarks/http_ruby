class Vote < ApplicationRecord
    self.primary_key = :user_id, :poll_id

    belongs_to :user
    belongs_to :poll
    belongs_to :option, query_constraints: [:poll_id, :option_num]

    validates :option_num, presence: true
    validates :user_id, presence: true
    validates :poll_id, presence: true
end
