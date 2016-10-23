# == Schema Information
#
# Table name: steps
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  video       :string(255)
#  order       :integer
#  track_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Step < ActiveRecord::Base
  belongs_to :track

  default_scope { order(:order) }

  has_many :step_achievements

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  #ATTENTION : erreur dans la doc de la gem. Il faut mettre theme au singulier...
  acts_as_taggable_on :step_type

  def is_completed_by?(a_user)
  	self.step_achievements.each do |step_achievement|
  		return true if a_user.step_achievements.include?(step_achievement)
  	end
  end

  def set_next_step
    next_step_order = self.order.to_i + 1
    steps = self.track.steps
    steps.find_by(order: next_step_order)
  end

end
