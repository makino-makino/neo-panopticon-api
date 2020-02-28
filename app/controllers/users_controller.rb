class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if not params[:followee].nil?
      @users = User.followees(params[:followee])

    elsif not params[:follower].nil?
      @users = User.followers(params[:follower])
    
    else
      @users = User.all

    end
  
    if not params[:number].nil?
      number = params[:number].to_is
    else
      number = 20
    end

    return @users.first(number)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @score = Evaluation.eval_user(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      # params.permit([:name, :email, :phone, :password])
      # params.require([:name, :email, :phone, :password])
      params.permit([:name, :email, :password])
      params.require([:name, :email, :password])

    end
end
