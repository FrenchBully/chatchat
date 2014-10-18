class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :interests, through: :interests_users

  def self.from_omniauth(auth)
    # gets and sets auth token for user
      where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid.to_s
      user.auth_token = auth.credentials.token
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end
end
