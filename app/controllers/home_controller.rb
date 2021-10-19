class HomeController < ApplicationController
  before_action :authenticate_admin_user!

  def index;
    redirect_to admin_dashboard_path
  end
end
