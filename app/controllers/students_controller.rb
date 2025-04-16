class StudentsController < ApplicationController
  before_action :set_student, only: [ :show ]
  before_action :set_school, only: [ :index ]

  def index
    @students = @school.students
  end

  def show
  end

  private

  def set_student
    @student = Student.includes(:contacts, :classrooms, :teachers, :notes).find(params[:id])
  end

  def set_school
    @school = current_user.school
  end
end
