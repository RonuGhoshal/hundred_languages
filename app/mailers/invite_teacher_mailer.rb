class InviteTeacherMailer < ApplicationMailer
  default from: current_user.email

  def invite_teacher(teacher, current_user)
    @teacher_first_name = teacher.first_name
    @sender = "#{current_user.first_name} #{current_user.last_name}"
    mail(to: @teacher.email, subject: "You have been invited to Hundred Languages")
  end
end
