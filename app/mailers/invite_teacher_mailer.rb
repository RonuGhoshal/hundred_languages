class InviteTeacherMailer < ApplicationMailer
  default from: "noreply@hundredlanguages.com"

  def invite_teacher(teacher, current_user)
    @teacher = teacher
    @sender = "#{current_user.first_name} #{current_user.last_name}"
    @school = teacher.school
    mail(to: teacher.email_address, subject: "You have been invited to Hundred Languages")
  end
end
