class StepsController < ApplicationController

  before_action :set_step, only: [:show, :edit, :destroy, :update]
  before_action :set_track, only: [:new, :create, :edit, :show, :destroy, :update]
  respond_to :json, :html

  def new
    @step = Step.new
  end

  def create
    @step = @track.steps.build(step_params)
    @step.title = "jour #{@step.order}"

#façon raccourcie :
#    if @step.save
#      respond_to @step,
#        location: track_step_url(@track, @step),
#        notice: 'Step was successfully created.'
#    else
#      respond_to @step
#    end

    respond_to do |format|
      if @step.save
        format.html { redirect_to track_step_url(@track, @step), notice: 'Step was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    authorize @step
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to track_step_url(@track,@step), notice: 'La step a bien été modifiée' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @step
    @step.destroy
    redirect_to track_url(@track)
  end

  def show
    authorize @step
  end

  def index
  end

  private

  def step_params
    params.require(:step).permit(:title, :description, :video, :order, :track_id, :audio, :step_type_list)
  end

  def set_track
    @track = Track.find(params[:track_id])
  end

  def set_step
    @step = Step.find(params[:id])
  end

end
