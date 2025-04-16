class StudentsController < ApplicationController
  before_action :set_student, only: [ :show ]
  before_action :set_school, only: [ :index ]

  def index
    @students = @school.students.includes(:classrooms, :teachers, :active_classroom)
  end

  def show
  end

  private

  def set_student
    @student = Student.includes(:classrooms, :teachers, :notes, :active_classroom).find(params[:id])
  end

  def set_school
    @school = current_user.school
  end
end
