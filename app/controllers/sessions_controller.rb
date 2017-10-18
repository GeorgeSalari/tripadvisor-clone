class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:sessions][:email])
    if @user
      if @user.authenticate(params[:sessions][:password])
        session[:user_id] = @user.id
        flash[:notice] = "Hello #{@user.first_name}"
        redirect_to user_path(@user)
      else
        @user = User.new
        flash.now[:error] = "Incorect password!"
        render "hotels/index"
      end
    else
      @user = User.new
      flash[:error] = "No such email in our database!"
      render "hotels/index"
    end
  end

  def create_google
    @user_omn = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = @user_omn.id
    redirect_to user_path(@user_omn)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end


