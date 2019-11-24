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

  def has_followed
    if (not params[:to_id].nil?) and (not params[:from_id].nil?)
      if not (@following = Following.find_by(to_id:params[:to_id], from_id:params[:from_id])).nil?  
        has_followed = true
        from_id = @following.from_id
        to_id = @following.to_id
      else
        has_followed = false
        from_id = nil
        to_id = nil
      end

      result = {
        'has_followed': has_followed,
        'from_id': from_id,
        'to_id': to_id,
      }

      render :json => result
    else
      render :show, status: 400, location: following
    end 
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
