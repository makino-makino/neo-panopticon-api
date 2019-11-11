class FollowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_following, only: [:show, :update, :destroy]

  # GET /followings
  # GET /followings.json
  def index
    @followings = Following.all
  end

  # GET /followings/1
  # GET /followings/1.json
  def show

  end

  # POST /followings
  # POST /followings.json
  def create
    @following = Following.new(following_params)
    @following.from = current_user

    if @following.save
      render :show, status: :created, location: @following
    else
      render json: @following.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /followings/1
  # PATCH/PUT /followings/1.json
  def update
    if @following.update(following_params)
      render :show, status: :ok, location: @following
    else
      render json: @following.errors, status: :unprocessable_entity
    end
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    @following.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find_by(to:params[:to], from: current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:to_id)
      params.permit(:to_id)
    end
end
