namespace :db do
  desc "Populate counter cache for classrooms"
  task populate_counter_cache: :environment do
    Classroom.find_each do |classroom|
      count = classroom.students.count
      classroom.update_column(:students_count, count)
      puts "Updated classroom #{classroom.id} with #{count} students"
    end
    puts "Counter cache population completed!"
  end
end 