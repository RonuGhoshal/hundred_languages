import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["teacherTemplate", "teacherTarget", "studentTemplate", "studentTarget", "contactTemplate", "contactTarget"]

  connect() {
    console.log("Classroom controller connected")
  }

  // Teacher form methods
  addTeacher(event) {
    event.preventDefault()
    
    const content = this.teacherTemplateTarget.content.cloneNode(true)
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
    
    this.teacherTargetTarget.appendChild(newContent)
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

  // Student form methods
  addStudent(event) {
    event.preventDefault()
    
    const content = this.studentTemplateTarget.content.cloneNode(true)
    const timestamp = new Date().getTime()
    const newContent = content.querySelector('div')
    
    // Update the child_index in the form fields
    newContent.querySelectorAll('input, select, textarea').forEach(field => {
      const name = field.getAttribute('name')
      if (name) {
        field.setAttribute('name', name.replace('NEW_RECORD', timestamp))
      }
      const id = field.getAttribute('id')
      if (id) {
        field.setAttribute('id', id.replace('NEW_RECORD', timestamp))
      }
    })
    
    this.studentTargetTarget.appendChild(newContent)
  }

  removeStudent(event) {
    event.preventDefault()
    
    const studentRow = event.target.closest('.bg-rose-50')
    if (studentRow) {
      // If this is an existing record, add a hidden field to mark it for deletion
      const studentId = studentRow.querySelector('input[name*="[id]"]')?.value
      if (studentId) {
        const destroyField = document.createElement('input')
        destroyField.type = 'hidden'
        destroyField.name = studentRow.querySelector('input[name*="[first_name]"]').name.replace('[first_name]', '[_destroy]')
        destroyField.value = '1'
        studentRow.appendChild(destroyField)
        studentRow.style.display = 'none'
      } else {
        // If it's a new record, just remove it
        studentRow.remove()
      }
    }
  }

  // Contact form methods
  addContact(event) {
    event.preventDefault()
    
    const content = this.contactTemplateTarget.content.cloneNode(true)
    const timestamp = new Date().getTime()
    const newContent = content.querySelector('div')
    
    // Update the child_index in the form fields
    newContent.querySelectorAll('input, select, textarea').forEach(field => {
      const name = field.getAttribute('name')
      if (name) {
        field.setAttribute('name', name.replace('NEW_CONTACT_RECORD', timestamp))
      }
      const id = field.getAttribute('id')
      if (id) {
        field.setAttribute('id', id.replace('NEW_CONTACT_RECORD', timestamp))
      }
    })
    
    // Find the closest contact target within the same student form
    const studentForm = event.target.closest('.bg-rose-50')
    const contactTarget = studentForm.querySelector('[data-classroom-target="contactTarget"]')
    contactTarget.appendChild(newContent)
  }

  removeContact(event) {
    event.preventDefault()
    
    const contactRow = event.target.closest('.bg-white')
    if (contactRow) {
      // If this is an existing record, add a hidden field to mark it for deletion
      const contactId = contactRow.querySelector('input[name*="[id]"]')?.value
      if (contactId) {
        const destroyField = document.createElement('input')
        destroyField.type = 'hidden'
        destroyField.name = contactRow.querySelector('input[name*="[name]"]').name.replace('[name]', '[_destroy]')
        destroyField.value = '1'
        contactRow.appendChild(destroyField)
        contactRow.style.display = 'none'
      } else {
        // If it's a new record, just remove it
        contactRow.remove()
      }
    }
  }
} 