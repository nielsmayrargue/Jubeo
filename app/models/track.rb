# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  price       :integer
#  intro_video :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  proof       :string(255)
#

require 'oembed'

class Track < ActiveRecord::Base

	belongs_to :user
	has_many :steps, dependent: :destroy
	has_many :attendings, dependent: :destroy
  has_many :ratings, through: :attendings
  has_many :coupons

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "user-400x400.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

	validates :title, presence: {:message => 'Votre Track doit avoir un titre !'}
	validates :price, numericality: { only_integer: true, message: "Le prix doit être un nombre" }
	validates :price, presence: {:message => 'Votre Track doit avoir un prix !'}
	validates :intro_video, format: { with: /(youtube.com.*(?:\/|v=)([^&$]+))|(vimeo.com)|/, message: "Le lien video n'est pas valide" }
	#Manque le message pour la dernière validation



	acts_as_taggable # Alias for acts_as_taggable_on :tags
	#ATTENTION : erreur dans la doc de la gem. Il faut mettre theme au singulier...
  acts_as_taggable_on :theme

  acts_as_commentable

  def average_rating
  	if self.ratings.size == 0
  		0
		else
			self.ratings.sum(:score) / (self.ratings.size)
		end
	end

	def is_attended_by?(a_user)
		self.attendings.each do |attending|
				return true if a_user == attending.user
		end
		false
	end

	def is_owned_by?(a_user)
		self.user == a_user
	end

	def self.with_keyword(keyword)
		return where('') if keyword.nil? or keyword.empty?
  	where("title LIKE ?", "%#{keyword}%")
  end

  def price_in_cents
  	self.price * 100
  end

  def last_completed_step(a_user)
  	completed_steps = []
  	self.steps.each do |step|
  		completed_steps << step if step.is_completed_by?(a_user) == true
  	end
  	completed_steps.sort! { |a,b| a.order <=> b.order }
  	last_completed_step = completed_steps.last
  end

  def current_step(a_user)
  	last_completed_step = self.last_completed_step(a_user)
  	return false if last_completed_step == nil
  	current_step = self.steps.find_by(order: (last_completed_step.order + 1))
  end

  def is_completed_by?(a_user)
  	if self.is_attended_by?(a_user)
  		return true if self.attendings.find_by(user: a_user).completed == true
  	end
  end

  def verify_coupon(name)
    self.coupons.each do |coupon|
      return true if coupon.name == name
    end
  end

end
