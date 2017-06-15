class UserActionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    actions = UserAction.all
    render json: actions
  end

  def create
    action = UserAction.new(action_params)
    action.save
    user = User.find(params[:user_action][:user_id])
    action.user = user
    wallet = action.user.wallets.first
    wallet.amount = params[:user_action][:wallet]
    wallet.save
    render json: {action: action, wallet: wallet}
  end

  private
  def action_params
    params.require(:user_action).permit(:user_id, :income, :total, :action, :current_price, :shares)
  end

end
