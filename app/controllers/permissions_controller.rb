class PermissionsController < ApplicationController

  def index
    @permissions = Permission.all
    render 'index'
  end

  def show
    @permission = Permission.find_by!(internal_name: params[:internal_name])
    render 'show'
  end

  def create
  end

  def update

  end

  def destroy

  end
end
