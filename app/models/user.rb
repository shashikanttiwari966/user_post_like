class User < ApplicationRecord

  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, authentication_keys: [:login]

  has_many :user_roles , dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy 
  has_many :likes, as: :like_on

  def role? user_role
    self.roles.collect(&:name).first == user_role
  end

end
