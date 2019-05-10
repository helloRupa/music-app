class SearchController < ApplicationController
  before_action :not_logged_in

  def index
    @query = params[:query]
    @bands, @albums, @tracks = [], [], []

    unless @query.empty?
      query = "%#{@query.upcase}%"
      @bands = Band.where('UPPER(name) LIKE ?', query)
      @albums = Album.where('UPPER(title) LIKE ?', query)
      @tracks = Track.where('UPPER(title) LIKE ? OR UPPER(lyrics) LIKE ?', query, query)
    end

    render :index
  end

  private

  def search_params
    params.require(:search).permit(:term)
  end
end
