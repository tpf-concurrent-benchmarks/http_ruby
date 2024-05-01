class FullPollSerializer < ActiveModel::Serializer
  attributes :id, :poll_topic, :poll_options
  has_many :poll_options, each_serializer: PollOptionSerializer
end
