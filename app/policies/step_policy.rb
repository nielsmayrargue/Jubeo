class StepPolicy < ApplicationPolicy
  #attr_reader :user, :step

  def initialize(user, step)
    @user = user
    @step = step
  end

  def update?
    @user == @step.track.user
  end

  def destroy?
    @user == @step.track.user
  end

  def show?
    @step.track.is_attended_by?(@user) == true || @user == @step.track.user
  end

end