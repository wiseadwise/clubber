class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
    @events = current_user.events
  end

end
