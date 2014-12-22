class UsersController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :index]
  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.decorate
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = @user.decorate
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
