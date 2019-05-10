class AlbumsController < ApplicationController
  before_action :not_logged_in

  def new
    @album = Album.new(band_id: params[:band_id])
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)
    @bands = Band.all

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:error] = @album.errors
      render :new
    end
  end

  def show
    @album = Album.find_by_id(params[:id])
    @band = @album.band
    @tracks = @album.tracks.order(:ord)
    render :show
  end

  def edit
    @album = Album.find_by_id(params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find_by_id(params[:id])
    @bands = Band.all

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:error] = @album.errors
      render :edit
    end
  end

  def destroy
    album = Album.find_by_id(params[:id])
    band = album.band

    if album
      album.destroy
      redirect_to band_url(band)
    end
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :year, :studio)
  end
end