class ProposalSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :title, :email, :budget, :invoice_paid, :proposal_accepted
  has_many :fees
  has_many :milestones
end
