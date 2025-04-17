class ClassroomsController < ApplicationController
  before_action :set_school, only: [ :create, :new, :edit, :update, :index ]
  before_action :set_classroom, only: [ :destroy, :show, :edit, :update ]

  def index
    @classrooms = @school.classrooms.includes(:students, :teachers, :classrooms_teachers)
  end

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

  def edit
    @available_years = AVAILABLE_YEARS
  end

  def update
    if @classroom.update(classroom_params.except(:classrooms_teachers_attributes))
      # Handle teachers separately
      if params[:classroom][:classrooms_teachers_attributes].present?
        teacher_ids = params[:classroom][:classrooms_teachers_attributes].values
          .reject { |attrs| attrs[:_destroy] == "1" }
          .map { |attrs| attrs[:teacher_id] }
        @classroom.update_teachers(teacher_ids)
      end

      redirect_to classroom_path(@classroom), notice: "Classroom was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
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
    params.require(:classroom).permit(
      :name,
      :school_year,
      students_attributes: [
        :id,
        :first_name,
        :last_name,
        :dob,
        :active_classroom_id,
        :school_id,
        :_destroy
      ]
    )
  end
end
