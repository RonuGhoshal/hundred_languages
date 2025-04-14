import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inviteTeachers", "teacherTemplate", "teacherTarget"]

  toggleInviteTeachers(event) {
    event.preventDefault()
    this.inviteTeachersTarget.classList.toggle("hidden")
  }

  addTeacherRow(event) {
    event.preventDefault()
    const content = this.teacherTemplateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.teacherTargetTarget.insertAdjacentHTML('beforeend', content)
  }

  removeTeacherRow(event) {
    event.preventDefault()
    event.target.closest('.teacher-row').remove()
  }
} 