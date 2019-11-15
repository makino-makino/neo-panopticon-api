class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    if not params[:followee].nil?
      @users = @users.where(id: Following.where(from_id: params[:followee]))
    end

    if not params[:follower].nil?
      @users = @users.where(id: Following.where(to_id: params[:follower]))
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @score = PostEvaluation.eval_user(@user)
  end

  # POST /users
  # POST /users.json
  # def create
  #  @user = User.new(user_params)
  #
  #  if @user.save
  #     render :show, status: :created, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  # def update
  #   if @user.update(user_params)
  #     render :show, status: :ok, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /users/1
  # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
