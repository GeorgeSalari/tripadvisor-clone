class SessionsController < ApplicationController
  def create
    @user_omn = User.from_omniauth(request.env["omniauth.auth"])
    if @user_omn
      session[:user_id] = @user_omn.id
      redirect_to user_path(@user_omn)
    else
      @user = User.find_by(email: params[:email])
      if @user
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          flash[:notice] = "Hello #{@user.first_name}"
          redirect_to user_path(@user)
        else
          @user = User.new
          flash.now[:error] = "Incorect password!"
          render "welcome/index"
        end
      else
        @user = User.new
        flash[:error] = "No such email in our database!"
        render "welcome/index"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end


