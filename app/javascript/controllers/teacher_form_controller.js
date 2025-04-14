import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "target"]

  connect() {
    console.log("Teacher form controller connected")
  }

  addTeacher(event) {
    event.preventDefault()
    
    const content = this.templateTarget.content.cloneNode(true)
    const timestamp = new Date().getTime()
    const newContent = content.querySelector('div')
    
    // Update the child_index in the form fields
    newContent.querySelectorAll('select, input').forEach(field => {
      const name = field.getAttribute('name')
      if (name) {
        field.setAttribute('name', name.replace('NEW_RECORD', timestamp))
      }
      const id = field.getAttribute('id')
      if (id) {
        field.setAttribute('id', id.replace('NEW_RECORD', timestamp))
      }
    })
    
    this.targetTarget.appendChild(newContent)
  }

  removeTeacher(event) {
    event.preventDefault()
    
    const teacherRow = event.target.closest('.bg-rose-50')
    if (teacherRow) {
      // If this is an existing record, add a hidden field to mark it for deletion
      const teacherId = teacherRow.querySelector('select[name*="[teacher_id]"]').value
      if (teacherId) {
        const destroyField = document.createElement('input')
        destroyField.type = 'hidden'
        destroyField.name = teacherRow.querySelector('select[name*="[teacher_id]"]').name.replace('[teacher_id]', '[_destroy]')
        destroyField.value = '1'
        teacherRow.appendChild(destroyField)
        teacherRow.style.display = 'none'
      } else {
        // If it's a new record, just remove it
        teacherRow.remove()
      }
    }
  }
} 