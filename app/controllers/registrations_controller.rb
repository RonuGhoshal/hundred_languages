class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @teacher = Teacher.new
    @teacher.build_school
  end

  def create
    @teacher = Teacher.new(teacher_params)
    @teacher.role = "admin" # First user is always an admin

    if @teacher.save
      start_new_session_for @teacher
      redirect_to after_authentication_url
    else
      render :new
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(
      :email_address,
      :password,
      :first_name,
      :last_name,
      :password_confirmation,
      school_attributes: [ :name, :address, :city, :state, :zip, :phone ]
    )
  end
end
