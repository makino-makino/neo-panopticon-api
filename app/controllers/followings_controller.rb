class FollowingsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_following, only: [:show, :create]

  # GET /followings
  # GET /followings.json
  def index
    params.permit(:to_id, :from_id)
    @followings = Following.all

    if not params[:from_id].nil?
      @followings = @followings.where(from: from_id)
    end
    
    if not params[:from_id].nil?
      @followings = @followings.where(to: to_id)
    end
    
  end

  # POST /followings
  # POST /followings.json
  def create
    unless @following.nil? then
      @following.destroy
    else
      @following = Following.new(from: current_user, to_id: params[:to_id])
      
      if @following.save
        render :show, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find_by(from: current_user, to_id: params[:to_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:to_id)
    end
end
