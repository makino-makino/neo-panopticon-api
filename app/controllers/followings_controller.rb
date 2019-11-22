class FollowingsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_following, only: [:show, :update, :destroy]

  # GET /followings
  # GET /followings.json
  def index
    @followings = Following.all
  end

  # GET /followings/1
  # GET /followings/1.json
  def show
    params.require(:id)
    @following = Following.find(params[:id])
  end

  # POST /followings
  # POST /followings.json
  def create
    params.require(:to_id)

    if not (following = Following.find_by(to_id:params[:to_id], from:current_user)).nil?
      @following = following
      render :show, status: 400, location: following
    else
      @following = Following.new(to_id:params[:to_id], from:current_user)

      if @following.save
        render :show, status: :created, location: @following
      else
        render json: @following.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /followings/1
  # PATCH/PUT /followings/1.json
  def update
    if @following.update(from: User.find(following_params[:from_id]), to: User.find(following_params[:to_id]))
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
      @following = Following.find_by(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:to_id)
      params.permit(:from_id)
    end
end
