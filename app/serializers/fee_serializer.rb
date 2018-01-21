class FeeSerializer < ActiveModel::Serializer
  attributes :id, :proposal_id, :price_breakdown, :content
  belongs_to :proposal
end
