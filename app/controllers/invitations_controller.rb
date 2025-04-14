class InvitationsController < ApplicationController
  before_action :require_admin

  def create
    success_count = 0
    error_messages = []

    ActiveRecord::Base.transaction do
      params[:teachers].each do |teacher_params|
        begin
          teacher = Teacher.invite(
            email_address: teacher_params[:email_address],
            first_name: teacher_params[:first_name],
            last_name: teacher_params[:last_name],
            school: current_user.school,
            invited_by: current_user
          )

          if teacher
            success_count += 1
          else
            error_messages << "Failed to invite #{teacher_params[:email_address]}"
          end
        rescue ActiveRecord::RecordInvalid => e
          error_messages << e.message
          raise ActiveRecord::Rollback
        rescue ActiveRecord::RecordNotUnique => e
          error_messages << "Email address #{teacher_params[:email_address]} is already registered"
          raise ActiveRecord::Rollback
        end
      end
    end

    if success_count > 0
      notice = "Successfully invited #{success_count} teacher#{'s' if success_count > 1}"
      notice += ". #{error_messages.join(', ')}" if error_messages.any?
      redirect_to root_path, notice: notice
    else
      redirect_to root_path, alert: "Failed to send any invitations. #{error_messages.join(', ')}"
    end
  end

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You don't have permission to invite teachers."
    end
  end
end 