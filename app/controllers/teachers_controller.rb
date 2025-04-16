class TeachersController < ApplicationController
  before_action :set_teacher, only: [ :show, :edit ]
  before_action :set_school, only: [ :index ]

  def index
    @teachers = @school.teachers.includes(:classrooms, :classrooms_teachers)
  end

  def show
  end

  def edit
  end

  private

  def set_teacher
    @teacher = Teacher.includes(:classrooms, :classrooms_teachers).find(params[:id])
  end

  def set_school
    @school = current_user.school
  end
end
