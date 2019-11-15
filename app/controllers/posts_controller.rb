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

    @posts = Post.where('id >= ? and created_at >= ?', start_id, start_created)
                 .where(id: users)
                 .first(numbers * 2)


    # 各投稿の評価値(投稿の新しさ * evaluation)と対応するインデックスをvaluesにしまう
    # 2要素の配列の配列
    values = []
    @posts.count.times do |i|
      values[i] = [@posts[i].evaluation * (numbers - i + 1), i]
    end

    # valuesを評価値に基づいてソート→必要な数を取り出す→二つ目の要素を順に@postsに入れる
    @posts = values.sort.first(numbers).reverse.map{ |x| x[1] }.sort.map{ |x| @posts[x] }

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
    if not (evaluation = Evaluation.find_by(post_id: @post.id, user_id: current_user.id)).nil? 
      @evaluation = evaluation
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
