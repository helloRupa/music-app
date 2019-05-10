class BandsController < ApplicationController
  before_action :not_logged_in

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:error] = @band.errors
      render :new
    end
  end

  def edit
    @band = Band.find_by_id(params[:id])
    render :edit
  end

  def update
    @band = Band.find_by_id(params[:id])

    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      flash.now[:error] = @band.errors
      render :edit
    end
  end

  def show
    @band = Band.find_by_id(params[:id])
    @albums = @band.albums
    render :show
  end

  def destroy
    band = Band.find_by_id(params[:id])

    if band
      band.destroy
      redirect_to bands_url
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end