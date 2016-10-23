# == Schema Information
#
# Table name: ratings
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  attending_id :integer
#  score        :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

class Rating < ActiveRecord::Base
  belongs_to :attending

end
