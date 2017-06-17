class UsersController < ApplicationController
protect_from_forgery :except => [:create]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(username: params[:username], password: params[:password])
    if @user.valid?
      @user.shares = 0
      @user.save
      @user.wallets.create(amount: 1000)
      token = JWT.encode({user_id: @user_id},ENV['JWT_SECRET'],'HS256')
      render json: {
          user: {
            id: @user.id,
            username: @user.username,
            shares: @user.shares,
            wallet: @user.wallets.first.amount
          },
          token: token
        }
      else
        render json: {error: "Something went wrong. Try another username or password"}
    end
  end

  def show
    user = User.find(params[:id])
    actions = user.user_actions
    wallet = user.wallets.first.amount
    render json: {user: user, actions: actions, wallet: wallet}
  end
  # def create
  #   action = UserAction.new(action_params)
  #   action.save
  #   user = User.find(params[:user_action][:user_id])
  #   action.user = user
  #   wallet = action.user.wallets.first
  #   wallet.amount = params[:user_action][:wallet]
  #   wallet.save
  #   render json: {action: action, wallet: wallet}
  # end

end
