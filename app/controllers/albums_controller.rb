class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    @tracks = @album.tracks
    @band = @album.band
  end
  
  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    render :new
  end
  
  def create
    @album = Album.new(album_params)
    @band = Band.find(@album.band_id)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end
  
  def edit
    @album = Album.find(params[:id])
    @band = @album.band
    
    render :edit
  end
  
  def update
    @album = Album.find(params[:id])
    @band = @album.band
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    @album.destroy!
    redirect_to band_url(@band)
  end
  
  private
  
    def album_params
      params.require(:album).permit(:name, :album_type, :band_id)
    end
end
