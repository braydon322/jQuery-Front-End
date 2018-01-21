class MilestoneSerializer < ActiveModel::Serializer
  attributes :id, :proposal_id, :due_date, :content
  belongs_to :proposal
end
