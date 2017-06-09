class UserActionsController < ApplicationController

  def index
    actions = UserAction.all
    render json: actions
  end

end
