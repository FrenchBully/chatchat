class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :interests, through: :interests_users

  # has_many :conversations, :foreign_key => :sender_id

  has_many :conversation_users
  has_many :conversations, through: :conversation_users
  has_many :messages
end
