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
        'retweeted'
        , id
        , updated_at
      FROM
        posts
      WHERE
        source_id = :id
      

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
