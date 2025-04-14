class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_teacher_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if teacher = Teacher.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(teacher).deliver_later
    end

    redirect_to new_session_path, notice: "Password reset instructions sent (if teacher with that email address exists)."
  end

  def edit
    if @teacher.invitation_token.present?
      @is_invitation = true
    end
  end

  def update
    if @teacher.update(params.permit(:password, :password_confirmation))
      if @teacher.invitation_token.present?
        @teacher.update(invitation_token: nil)
        start_new_session_for @teacher
        redirect_to root_path, notice: "Your account has been set up successfully."
      else
        redirect_to new_session_path, notice: "Password has been reset."
      end
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
    end
  end

  private
    def set_teacher_by_token
      @teacher = Teacher.find_by_invitation_token!(params[:token])
    rescue ActiveRecord::RecordNotFound
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end
end
