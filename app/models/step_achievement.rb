# == Schema Information
#
# Table name: step_achievements
#
#  id           :integer          not null, primary key
#  attending_id :integer
#  step_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class StepAchievement < ActiveRecord::Base
  belongs_to :attending, dependent: :destroy
  belongs_to :step
end
