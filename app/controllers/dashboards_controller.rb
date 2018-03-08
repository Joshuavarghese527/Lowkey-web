class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
     @locations = Location.where(active: true).limit(3)
  end
end