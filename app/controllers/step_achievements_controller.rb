class StepAchievementsController < ApplicationController

  before_action :set_step, only: [:new, :create]
  before_action :set_track, only: [:create]

  def create
    attending = current_user.attendings.find_by(track_id: @step.track.id)
    attending.step_achievements.create(step: @step)
    next_step = @step.set_next_step
    attending.is_completed?
    respond_to do |format|
    if next_step == nil
      redirection = track_url(@track)
    else
      redirection = track_step_url(@track, next_step)
    end
      format.html { redirect_to redirection }
      format.js { redirect_to redirection }
    end
  end

  def set_step
    @step = Step.find(params[:step_id])
  end

  def set_track
    @track = @step.track
  end

end
