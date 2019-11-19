class NotificationsController < ApplicationController
  # before_action :set_notification, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /notifications
  # GET /notifications.json
  def index
    query = <<'EOS'
      SELECT 
        'replied'
        , id
        , updated_at
      FROM
        posts
      WHERE
        content LIKE :name

      UNION SELECT
        'followed'
        , id
        , updated_at
      FROM
        followings
      WHERE
        to_id = :id
      ORDER BY
        updated_at DESC 
      LIMIT
        100
      ;
EOS

    query = ActiveRecord::Base.send(
      :sanitize_sql_array,
      [query, id:current_user.id, name: "%@#{current_user.name} %"]
    )

    con = ActiveRecord::Base.connection
    @notifications = con.select_all(query)

    puts @notifications
  end


  # # GET /notifications/1
  # # GET /notifications/1.json
  # def show
  # end

  # # POST /notifications
  # # POST /notifications.json
  # def create
  #   @notification = Notification.new(notification_params)

  #   if @notification.save
  #     render :show, status: :created, location: @notification
  #   else
  #     render json: @notification.errors, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /notifications/1
  # # PATCH/PUT /notifications/1.json
  # def update
  #   if @notification.update(notification_params)
  #     render :show, status: :ok, location: @notification
  #   else
  #     render json: @notification.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /notifications/1
  # # DELETE /notifications/1.json
  # def destroy
  #   @notification.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.fetch(:notification, {})
    end
end
