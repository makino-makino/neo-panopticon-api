# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable # , :trackable
  include DeviseTokenAuth::Concerns::User
  validates :name, uniqueness: true
  validates :email, uniqueness: true
  validates :phone, uniqueness: true

  def self.followees(followee)
    followees_ids = Following.where(from_id: followee).select("to_id")
    return where(id: followees_ids)
  end

  def self.followers(follower)
    followers_ids = Following.where(to_id: follower).select("from_id")
    return where(id: followers_ids)
  end
end
