class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluation, only: [:show, :update, :destroy]

  # GET /evaluations
  # GET /evaluations.json
  def index
    @evaluations = Evaluation.all
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
    params.require(:id)
    @evaluation = Evaluation.find(params[:id])
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    if not (@evaluation = Evaluation.find_by(post_id:params[:post_id], user_id: current_user)).nil?
      @evaluation.is_positive = params[:is_positive]
    else
      @evaluation = Evaluation.new(post_id: params[:post_id], is_positive: params[:is_positive], user: current_user)
    end

    if @evaluation.save
      render :show, status: :created, location: @evaluation
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  def update
    if @evaluation.update(evaluation_params)
      render :show, status: :ok, location: @evaluation
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.fetch(:evaluation, {})
    end
end
