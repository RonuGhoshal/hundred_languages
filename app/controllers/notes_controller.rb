class NotesController < ApplicationController
  before_action :set_note, only: [ :show ]
  before_action :set_school, only: [ :index, :new ]

  def index
    @notes = current_user.notes.includes(:students, :author)
  end

  def show
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.build(note_params)
    @note.author = current_user

    if @note.save
      redirect_to note_path(@note), notice: "Note was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_note
    @note = Note.includes(:students, :author).find(params[:id])
  end

  def set_school
    @school = current_user.school
  end

  def note_params
    params.require(:note).permit(:title, :content, student_ids: [])
  end
end
