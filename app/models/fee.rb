class Fee < ActiveRecord::Base
  belongs_to :proposal
  validates_presence_of   :content, allow_blank: false
  validates_presence_of   :price_breakdown, allow_blank: false
end
