class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  validates :email, presence: true
  validates :user_type, presence: true
  enum user_type: { developer: 0, manager: 1, qa: 2}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :bugs
  has_and_belongs_to_many :projects
end
