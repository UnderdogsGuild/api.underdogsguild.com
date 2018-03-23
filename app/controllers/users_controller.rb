class UsersController < ApplicationController
  def index
    if params[:permission_internal_name]
      permission = Permission.find_by!(internal_name: params[:permission_internal_name])
      list_type = list_action(request.url)
      case list_type
        when /^direct_users/
          @users = permission.users
        when /^indirect_users/
          @users = permission.indirect_users
        when /^all_users/
          @users = permission.all_users
        else
          raise ActionController::RoutingError.new('Not Found')
      end
    else
      @users = User.all
    end

    render :index
  end
end
