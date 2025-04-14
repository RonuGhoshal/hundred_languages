class HomeController < ApplicationController
  def index
    @classrooms = current_user.classrooms
  end
end
