class TrackPolicy < ApplicationPolicy
  #attr_reader :user, :track

  def initialize(user, track)
    @user = user
    @track = track
  end

  def create?
   @user.is_a_coach == true
  end

  def new?
    @user.is_a_coach == true
  end

  def update?
    @user == @track.user && @user.is_a_coach == true
  end

  def edit?
    @user == @track.user && @user.is_a_coach == true
  end

  def destroy?
    @user == @track.user && @user.is_a_coach == true
  end

end