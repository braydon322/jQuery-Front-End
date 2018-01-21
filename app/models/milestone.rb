class Milestone < ActiveRecord::Base
  belongs_to :proposal
  validates_presence_of   :content, allow_blank: false
  validates_presence_of   :due_date, allow_blank: false
end
