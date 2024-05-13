class FullPollSerializer < ActiveModel::Serializer
  attributes :id, :title, :options
  has_many :options, each_serializer: OptionSerializer
end
