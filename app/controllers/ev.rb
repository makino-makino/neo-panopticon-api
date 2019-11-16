class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluation, only: [:show, :update, :destroy]

  # GET /evaluation
  # GET /evaluation.json
  def index
    @evaluations = Evaluation.all
  end

  # GET /evaluation/1
  # GET /evaluation/1.json
  def show
    params.require(:id)
    @evaluation = Evaluation.find(params[:id])
  end

  # POST /evaluation
  # POST /evaluation.json
  def create
    # params.require(:post_id, :is_positive)

    if not (evaluation = Evaluation.find_by(post_id:params[:post_id], user_id: current_user)).nil?
      @evaluation = evaluation
      render :show, status: 400, location: evaluation
    else
      @evaluation = Evaluation.new(post_id: params[:post_id], user_id: current_user, is_positive: params[:is_positive])

      if @evaluation.save
        render :show, status: :created, location: @evaluation
      else
        render json: @evaluation.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  # def update
  #   if @evaluation.update(following_params)
  #     render :show, status: :ok, location: @evaluation
  #   else
  #     render json: @evaluation.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  # def destroy
  #   @evaluation.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find_by(post_id: params[:post_id], user_id:params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:post_id, :user_id)
      params.permit(:post_id, :user_id)
    end
end
