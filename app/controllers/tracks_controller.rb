class TracksController < ApplicationController
  def show
    @track = Track.find(params[:id])
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
   
  private
  
    def track_params
      params.require(:track).permit(:album_id, :track_type, :lyrics)
    end
end
