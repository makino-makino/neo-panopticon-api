class EvaluationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluation, only: [:create]

  # POST /evaluations
  # POST /evaluations.json
  def create
    is_positive = @evaluation.is_positive

    if @evaluation.update_attributes(is_positive: !is_positive)
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
