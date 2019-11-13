class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:eval, :show, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    params.require(:type)
    params.permit(:type, :numbers, :start_created, :start_id)

    # set values
    if params[:type] == "global"
      users = User.all
    elsif params[:type] == "local"
      users = User.where(id: Following.where(from: current_user.id))
    end

    if not params[:numbers].nil?
      numbers = params[:numbers].to_i
    else
      numbers = 20
    end

    if not params[:start_created].nil?
      start_created = params[:start_created]
    else
      start_created = 0
    end

    if not params[:start_id].nil?
      start_id = params[:start_id]
    else
      start_id = 0
    end

    @posts = Post.where('id > ? and created_at > ?', start_id, start_created)
                 .where(id: users)
                 .first(numbers)

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @score = PostEvaluation.eval_post(@post)
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def eval
    params.require(:score)
    params.permit(:score)
    score = params[:score]

    # TODO: Validation
    # -> done

    @post = Post.find_by(params['id'])

    # validate
    # return falseを仮置き
    if PostEvaluation.find(@post.id) then return false end

    @evaluation = PostEvaluation.new(post: @post, user:current_user, score: score)

    if @evaluation.save
      render :eval
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  # def update
  #   if @post.update(post_params)
  #     render :show, status: :ok, location: @post
  #   else
  #     render json: @post.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /posts/1
  # DELETE /posts/1.json
  # def destroy
  #   @post.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:content)
      params.permit(:content)
    end
end
