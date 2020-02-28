class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:eval, :show, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    params.permit(:tl, :numbers, :start_created, :start_id, :user_id)

    numbers = params[:numbers].nil? ? 10 : params[:numbers].to_i
    start_id = params[:start_id].nil? ? 0 : params[:start_id].to_i
    start_created = params[:start_created].nil? ? 0 : params[:start_created].to_i

    # if params[:tl] == "local"
    #   followings = Following.where(from: current_user)
    #   users = User.where(user: followings)
    # else
      users = User.all
    # end


    @posts = Post.tl(params[:tl], users, numbers, start_id, start_created)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @score = Evaluation.eval_post(@post)
  end

  # POST /posts
  # POST /posts.json
  def create
    params.permit(:content, :souce_id)

    if params[:source_id].nil?
      # 普通のポスト
      @post = Post.new(content: params[:content])
    elsif not Post.find(params[:source_id]).nil?
      # リツイート
      @post = Post.new(content: params[:content], source_id: params[:source_id])
    end

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

    @post = Post.find(params['id'])

    # validate
    @evaluation = Evaluation.find_by(post_id: @post.id, user_id: current_user.id)
    if not (@evaluation).nil? 
      render :eval
    else
      @evaluation = Evaluation.new(post: @post, user:current_user, score: score)

      if @evaluation.save
        render :eval
      else
        render json: @evaluation.errors, status: :unprocessable_entity
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:content)
      params.permit(:content) #, :type, :souce_id)
    end

end
