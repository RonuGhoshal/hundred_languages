class InviteTeacherMailer < ApplicationMailer
  def invite_teacher(teacher, current_user)
    @teacher_first_name = teacher.first_name
    @sender = "#{current_user.first_name} #{current_user.last_name}"
    mail(
      from: current_user.email_address,
      to: teacher.email_address,
      subject: "You have been invited to Hundred Languages"
    )
  end
end
