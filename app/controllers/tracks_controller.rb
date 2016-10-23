class TracksController < ApplicationController

  before_action :set_track, only: [:show, :edit, :update, :destroy]
  before_action :get_all_themes, only: [:index, :edit, :new]

  def new
    @track = Track.new
    authorize @track
    get_all_themes

  end

  def create
    @track = current_user.tracks.build(track_params)
    themes_array = params[:track][:theme_list].reject { |c| c.empty? }
    themes_array.each do |theme|
      @track.theme_list.add(theme)
    end
    respond_to do |format|
      if @track.save
        format.html { redirect_to track_url(@track), notice: 'Votre Track a bien été créé' }
        format.json { head :no_content }
      else
        format.html { render action: 'new', notice: 'Erreurs' }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @attending = current_user.attending(@track)
    @rating = @attending.rating unless @attending.nil?
    @all_comments = @track.comment_threads
  end

  def edit
    authorize @track #on appelle la méthode authorize de pundit en passant @track
  end

  def update
    authorize @track
    themes_array = params[:track][:theme_list].reject { |c| c.empty? }
    themes_array.each do |theme|
      @track.theme_list.add(theme)
    end
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Votre Coaching a bien été édité.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def index
    if params.has_key?(:track)
      if params[:track].has_key?(:themes)
        asked_themes = params[:track][:themes]
        #asked_themes = asked_themes.reject { |c| c.empty? }
          @tracks = Track.tagged_with(asked_themes, on: :theme, any: true)
      else
        @tracks = Track.all
      end
    elsif params[:search]
      @tracks = Track.with_keyword(params[:search])
      Track.tagged_with(params[:search], on: :theme, any: true).each do |track|
        @tracks << track
      end
      @tracks
    else
      @tracks = Track.all
    end
  end

  def index_attending_tracks
    @current_attending_track = current_user.current_attending_track
  end

  def index_owned_tracks
  end

  private

  def set_track
    @track = Track.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:title, :description, :price, :intro_video, :user_id, :theme_list, :proof, :picture)
  end

  def get_all_themes
    @all_themes = Track.tag_counts_on(:theme)
  end

end
