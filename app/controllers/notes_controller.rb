class NotesController < ApplicationController
  before_action :set_note, only: [ :show ]
  before_action :set_school, only: [ :index, :new ]

  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new
  end

  def create
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def set_school
    @school = current_user.school
  end
end
