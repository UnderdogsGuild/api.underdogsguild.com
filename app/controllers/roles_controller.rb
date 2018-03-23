class RolesController < ApplicationController
  def index
    if params[:permission_internal_name]
      @roles = Permission.find_by!(internal_name: params[:permission_internal_name]).roles
    else
      @roles = Role.all
    end

    render :index
  end
end
