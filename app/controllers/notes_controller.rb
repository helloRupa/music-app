class NotesController < ApplicationController
  before_action :not_logged_in

  def create
    note = Note.new(note_params)
    note.user_id = current_user.id
    note.track_id = params[:id]

    flash[:error] = 'Unable to save note, please try again' unless note.save
    redirect_to request.referrer
  end

  def destroy
    note = Note.find_by_id(params[:id])
    if note
      note.destroy
    end
    redirect_to request.referrer
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id, :body)
  end
end