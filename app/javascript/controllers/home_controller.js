import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inviteTeachers", "teacherTemplate", "teacherTarget", "flashMessages"]

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

  async submitForm(event) {
    event.preventDefault()
    const form = event.target
    const formData = new FormData(form)

    try {
      const response = await fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      })

      const data = await response.json()

      if (response.ok) {
        this.showFlashMessage(data.notice, 'success')
        this.toggleInviteTeachers(event)
      } else {
        this.showFlashMessage(data.alert, 'error')
      }
    } catch (error) {
      this.showFlashMessage('An error occurred while sending invitations. Please try again.', 'error')
    }
  }

  showFlashMessage(message, type) {
    const flashDiv = document.createElement('div')
    flashDiv.className = `bg-${type === 'success' ? 'green' : 'red'}-100 border border-${type === 'success' ? 'green' : 'red'}-400 text-${type === 'success' ? 'green' : 'red'}-700 px-4 py-3 rounded relative mb-4`
    flashDiv.setAttribute('role', 'alert')
    
    const messageSpan = document.createElement('span')
    messageSpan.className = 'block sm:inline'
    messageSpan.textContent = message
    flashDiv.appendChild(messageSpan)

    this.flashMessagesTarget.innerHTML = ''
    this.flashMessagesTarget.appendChild(flashDiv)
  }
} 