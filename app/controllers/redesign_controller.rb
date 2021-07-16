
class RedesignController < ApplicationController
  # before_action :admin_user

  # def admin_user
  #   if current_user.admin?
  #     render template: 'layouts/application'
  #   end
  # end

  def index
    render template: 'layouts/redesign'
  end
end
