class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:eval, :show, :update, :destroy]

  DEFAULT_NUMBER = 20
  DEFAULT_START_ID = 0

  # GET /posts
  # GET /posts.json
  def index
    # ToDo: start_idの適用
    params.permit(:tl, :number, :start_id, :user_id, :type)

    number = params[:number].nil? ? DEFAULT_NUMBER : params[:number].to_i
    start_id = params[:start_id].nil? ? DEFAULT_START_ID : params[:start_id].to_i
    user_id = params[:user_id]

    @posts = Post.all.where(`start_id <= ?`, start_id)
    if params[:type] == "local"
      @posts = Post.local(current_user)
    elsif params[:type] == 'user' && !user_id.nil?
      @posts = Post.where(user_id: user_id)
    end

    @posts = @posts.last(number * 2)
    @posts = Post.choose(@posts)
  end

  # POST /posts
  # POST /posts.json
  def create
    params.permit(:content, :souce_id)

    @post = Post.new(content: params[:content])
    @post.user = current_user

    if @post.save
      render :show, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:content)
      params.permit(:content)
    end

end
