class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @teacher = Teacher.new
    @teacher.build_school
  end

  def create
    @school = School.new(school_params)
    @teacher = Teacher.new(teacher_params)
    @teacher.school = @school
    @teacher.role = 'admin' # First user is always an admin

    if @school.save && @teacher.save
      start_new_session_for @teacher
      redirect_to after_authentication_url
    else
      render :new
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :address, :city, :state, :zip, :phone)
  end

  def teacher_params
    params.require(:teacher).permit(:email_address, :password, :first_name, :last_name, :password_confirmation)
  end
end