class Option < ApplicationRecord
    self.primary_key = :poll_id, :option_num

    belongs_to :poll
    has_many :votes, query_constraints: [:poll_id, :option_num], dependent: :destroy

    validates :option_text, presence: true
    validates :option_num, presence: true
end
