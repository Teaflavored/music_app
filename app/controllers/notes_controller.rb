class NotesController < ApplicationController
  before_action :redirect_to_sign_in_if_not_logged_in
  
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @track = Track.find(params[:track_id])
    @note.track = @track
    if @note.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@track)
    end
  end
  
  def destroy
    @note = Note.find(params[:id])
    raise "Hell" if @note.user_id != current_user.id
    @track = @note.track
    @note.destroy!
    redirect_to track_url(@track)
  end
  
  private
  
    def note_params
      params.require(:note).permit(:body)
    end
end
