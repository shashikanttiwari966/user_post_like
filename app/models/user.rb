class User < ApplicationRecord

  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook], authentication_keys: [:login]

  has_many :user_roles , dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy 
  has_many :likes, as: :like_on

  def role? user_role
    self.roles.collect(&:name).first == user_role
  end

  def self.create_from_provider_data(provider_data)
    debugger
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
      user.user_name = provider_data.info.user_name
      user.role = provider_data.info.role
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.save
    end
  end

end
