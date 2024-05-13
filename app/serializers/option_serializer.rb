class OptionSerializer < ActiveModel::Serializer
  attributes :name, :votes

  def name
    object.option_text
  end
  
  def votes
    object.votes.count
  end
end
