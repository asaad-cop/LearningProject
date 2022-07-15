class PagesController < ApplicationController
  def home
  end

  def users
    @userss = User.all
  end

end
