class TracksController < ApplicationController
  def show
    @track = Track.find(params[:id])
    @album = @track.album
    render :show
  end
  
  def new
    @album = Album.find(params[:album_id])
    @track = Track.new
    render :new
  end
  
  def create
    @track = Track.new(track_params)
    @album = Album.find(@track.album_id)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end
  
  def edit
    @track = Track.find(params[:id])
    @album = @track.album
    render :edit
  end
  
  def update
    @track = Track.find(params[:id])
    @album = @track.album
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy!
    redirect_to album_url(@album)
  end
   
  private
  
    def track_params
      params.require(:track).permit(:album_id, :track_type, :lyrics, :name)
    end
end
