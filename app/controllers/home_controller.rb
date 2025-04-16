class HomeController < ApplicationController
  def index
    @classrooms = current_user.classrooms.includes(:students, :teachers, :classrooms_teachers)
  end
end
