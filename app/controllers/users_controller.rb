class UsersController < ApplicationController
  #skip_before_action :verify_authenticity_token

  def index
    @users = User.all
    render json: @users
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      render json: user
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
