# use existing school
school = School.find(1)

# Create classrooms
classrooms = [
  Classroom.create!(name: "Kindergarten A", school_year: "2023-2024", school_id: school.id),
  Classroom.create!(name: "Kindergarten B", school_year: "2023-2024", school_id: school.id),
  Classroom.create!(name: "1st Grade A", school_year: "2023-2024", school_id: school.id)
]

# Create or find teachers
teachers = [
  Teacher.find_or_create_by!(email_address: "ms.smith@sunshine.edu") do |teacher|
    teacher.password = BCrypt::Password.create("password123")
    teacher.first_name = "Sarah"
    teacher.last_name = "Smith"
    teacher.school_id = school.id
    teacher.role = "teacher"
  end,
  Teacher.find_or_create_by!(email_address: "mr.johnson@sunshine.edu") do |teacher|
    teacher.password = BCrypt::Password.create("password123")
    teacher.first_name = "Michael"
    teacher.last_name = "Johnson"
    teacher.school_id = school.id
    teacher.role = "teacher"
  end,
  Teacher.find_or_create_by!(email_address: "ms.williams@sunshine.edu") do |teacher|
    teacher.password = BCrypt::Password.create("password123")
    teacher.first_name = "Emily"
    teacher.last_name = "Williams"
    teacher.school_id = school.id
    teacher.role = "teacher"
  end
]

# Create students
students = [
  Student.create!(
    first_name: "Emma",
    last_name: "Davis",
    dob: Date.new(2018, 5, 15),
    active_classroom: classrooms[0],
    school_id: school.id
  ),
  Student.create!(
    first_name: "Liam",
    last_name: "Wilson",
    dob: Date.new(2018, 7, 22),
    active_classroom: classrooms[0],
    school_id: school.id
  ),
  Student.create!(
    first_name: "Olivia",
    last_name: "Brown",
    dob: Date.new(2017, 3, 10),
    active_classroom: classrooms[1],
    school_id: school.id
  ),
  Student.create!(
    first_name: "Noah",
    last_name: "Taylor",
    dob: Date.new(2017, 9, 5),
    active_classroom: classrooms[1],
    school_id: school.id
  ),
  Student.create!(
    first_name: "Ava",
    last_name: "Anderson",
    dob: Date.new(2016, 11, 30),
    active_classroom: classrooms[2],
    school_id: school.id
  )
]

# Create notes
notes = [
  Note.create!(
    content: "Emma and Liam are working well together in their reading group. They've developed a great partnership and help each other learn new words.",
    author_id: teachers[0].id
  ),
  Note.create!(
    content: "Liam needs additional support with math concepts. Will implement extra practice sessions.",
    author_id: teachers[0].id
  ),
  Note.create!(
    content: "Olivia and Noah have shown excellent teamwork during science experiments. They're both very curious and ask thoughtful questions.",
    author_id: teachers[1].id
  )
]

# Associate notes with students
notes[0].students << students[0] << students[1]
notes[1].students << students[1]
notes[2].students << students[2] << students[3]

# Associate teachers with classrooms
classrooms[0].teachers << teachers[0]
classrooms[1].teachers << teachers[1]
classrooms[2].teachers << teachers[2]

# Associate students with classrooms
classrooms[0].students << students[0] << students[1]
classrooms[1].students << students[2] << students[3]
classrooms[2].students << students[4]

puts "Seed data created successfully!"

Student.all.each do |student|
  student.photo_url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJUpgneQsvxDdoIInnxNnVH09aT4IE7rVXOg&s"
  student.save!
end
