class TracksController < ApplicationController
  before_action :not_logged_in

  def new
    @track = Track.new(album_id: params[:album_id])
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:error] = @track.errors
      render :new
    end
  end

  def edit
    @track = Track.find_by_id(params[:id])
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find_by_id(params[:id])
    @albums = Album.all

    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors
      render :edit
    end
  end

  def show
    @track = Track.find_by_id(params[:id])
    @album = @track.album
    @notes = @track.notes
    render :show
  end

  def destroy
    track = Track.find_by_id(params[:id])
    album = track.album

    if track
      track.destroy
      redirect_to album_url(album)
    end
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :lyrics, :regular)
  end
end