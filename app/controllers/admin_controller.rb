class AdminController < ApplicationController
  layout 'admin'
  before_action :require_admin

  def index; end

  def require_admin
    redirect_to(root_url) unless current_user&.admin?
  end
end
