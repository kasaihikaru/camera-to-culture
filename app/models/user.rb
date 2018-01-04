class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :customers
	has_many :clients
	has_many :user_languages
	accepts_nested_attributes_for :user_languages


	# ファイルアップロード処理
	mount_uploader :image, ImageUploader
end