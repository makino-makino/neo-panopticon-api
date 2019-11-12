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

end
