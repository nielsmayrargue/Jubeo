# == Schema Information
#
# Table name: attendings
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  track_id         :integer
#  transaction_cost :integer
#  is_paid          :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

class Attending < ActiveRecord::Base
  belongs_to :user
  belongs_to :track
  has_one :rating
  has_many :step_achievements


def starting_date
	date = self.created_at
	day = date.day
	month = date.month
	year = date.year
	starting_date = "le #{day}/#{month}/#{year}"
end

def number_of_completed_days
	number_of_completed_days = 0
	self.track.steps.tagged_with("contenu", :on => :step_type, :any => true).each do |step|
		number_of_completed_days += 1 if step.is_completed_by?(User.find(self.user)) == true
	end
	number_of_completed_days
end

def completion
	self.number_of_completed_days
	total_days = self.track.steps.count
	completion = "#{number_of_completed_days} sur #{total_days}"
end

def is_completed?
	self.completed = true if (self.number_of_completed_days/self.track.steps.tagged_with("contenu", :on => :step_type, :any => true).count) == 1
	self.save
	self.completed
end

end
