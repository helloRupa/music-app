class NotesController < ApplicationController
  before_action :not_logged_in

  def create
    note = Note.new(note_params)
    note.user_id = current_user.id
    note.track_id = params[:track_id]

    flash[:error] = 'Note cannot be blank!' unless note.save
    redirect_to request.referrer
  end

  def destroy
    note = Note.find_by_id(params[:id])

    if note && current_user.id == note.user_id
      note.destroy
      redirect_to request.referrer
    else
      render plain: 'Forbidden, you cannot do that!', status: :forbidden
    end
  end

  private

  def note_params
    params.require(:note).permit(:track_id, :body)
  end
end