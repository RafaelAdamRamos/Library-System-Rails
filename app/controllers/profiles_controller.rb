class ProfilesController < ApplicationController
  before_action :logged_in?

  def show
    @user = current_user
  end
end
