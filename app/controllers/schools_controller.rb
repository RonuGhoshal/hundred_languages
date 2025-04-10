class SchoolsController < ApplicationController
  before_action :require_admin
  before_action :set_school

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to root_path, notice: "School information updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_school
    @school = current_user.school
  end

  def school_params
    params.require(:school).permit(:name, :address, :city, :state, :zip, :phone)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to perform this action."
    end
  end
end 