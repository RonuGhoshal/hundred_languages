class ClassroomsController < ApplicationController
  before_action :set_school, only: [ :create, :new ]
  before_action :set_classroom, only: [ :destroy, :show ]

  def create
    @classroom = @school.classrooms.build(classroom_params)

    if @classroom.save
      redirect_to edit_school_path(@school), notice: "Classroom was successfully created."
    else
      redirect_to edit_school_path(@school), alert: "Failed to create classroom."
    end
  end

  def new
    @classroom = @school.classrooms.build
  end

  def destroy
    school = @classroom.school
    @classroom.destroy
    redirect_to edit_school_path(school), notice: "Classroom was successfully deleted."
  end

  def show
  end

  private

  def set_school
    @school = current_user.school || School.find(params[:school_id])
  end

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:name, :school_year, teachers_attributes: [ :email_address, :role ], students_attributes: [ :first_name, :last_name, :dob, contacts_attributes: [ :name, :phone, :email, :relationship ] ])
  end
end
