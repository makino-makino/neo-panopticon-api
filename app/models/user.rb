# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable# , :trackable
  include DeviseTokenAuth::Concerns::User
  validates :name, uniqueness: true
  validates :email, uniqueness: true
  # validates :phone, uniqueness: true

  def followees
    followees_ids = Following.where(from: self.id).select("to_id")
    return User.where(id: followees_ids)
  end

  def followers
    followers_ids = Following.where(from: self.id).select("from_id")
    return User.where(id: followers_ids)
  end
end
