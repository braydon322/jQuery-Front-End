class Proposal < ActiveRecord::Base
  belongs_to :user
  has_many :fees
  has_many :milestones
  validates_presence_of   :email, allow_blank: false
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , format: { with: VALID_EMAIL_REGEX }
  validates_presence_of   :title, allow_blank: false, length: { maximum: 50 }
  validates_presence_of   :budget, allow_blank: false, min: 0

  def self.total_earned(current_admin)
    total_earned = 0
    current_admin.proposals.each do |t|
      total_earned += t.budget
    end
    total_earned
  end

  def url=(url)
    self.url = url
  end


  def self.total_projects(current_admin)
    current_admin.proposals.size
  end

  def self.clients(current_admin)
    clients = []
    current_admin.proposals.each do |t|
      clients << t.user
    end
    clients
  end


  def self.sort(proposals, sort_type)
    if sort_type == "price_up"
    proposals.order(budget: :asc)
    elsif sort_type == "price_down"
    proposals.order(budget: :desc)
    elsif sort_type == "date_up"
    proposals.order(created_at: :asc)
    elsif sort_type == "date_down"
    proposals.order(created_at: :desc)
    elsif sort_type == "signed"
    proposals.where(:proposal_accepted => true)
    elsif sort_type == "unsigned"
    proposals.where(:proposal_accepted => !true)
    else
    proposals
    end
  end

  def milestones_attributes=(milestones_attributes)
    milestones_attributes.each do |i, milestone_attributes|
      begin
        if Milestone.find(milestone_attributes[:id].to_i)
          @milestone = Milestone.find(milestone_attributes[:id].to_i)
          @milestone.content = milestone_attributes[:content]
          @milestone.due_date = milestone_attributes[:due_date]
          @milestone.save
        else
          self.milestones.build(milestone_attributes)
        end
      rescue
          self.milestones.build(milestone_attributes)
      end
    end
  end

  def fees_attributes=(fees_attributes)
    fees_attributes.each do |i, fee_attributes|
      begin
        if Milestone.find(fee_attributes[:id].to_i)
          @fee = Fee.find(fee_attributes[:id].to_i)
          @fee.content = fee_attributes[:content]
          @fee.price_breakdown = fee_attributes[:price_breakdown]
          @fee.save
        else
          self.fees.build(fee_attributes)
        end
      rescue
        self.fees.build(fee_attributes)
      end
    end
  end
end
