class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluation, only: [:create]

  DEFAULT_POST_ID = 0

  # GET /evaluations
  # GET /evaluations.json
  def index
    params.permit(:user_id, :post_id)
    @evaluations = Evaluation.all

    user_id = params[:user_id]
    post_id = params[:post_id]

    unless post_id.nil? then
      @evaluations = @evaluation.where(user_id: user_id)
    end

    unless post_id.nil? then
      @evaluations = @evaluation.where(post_id: post_id)
    end
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    # ToDo: 名前の変更
    score = params[:score]
    

    if @evaluation.update_attributes(score: score)
      render :show, status: :ok, location: @evaluation
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find_or_create_by(post_id:params[:post_id], user: current_user)
    end
end
