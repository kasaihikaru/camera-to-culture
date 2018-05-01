class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable, :omniauthable

  #メール認証外す
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	has_one :customer
	has_one :client
	has_many :user_languages
	accepts_nested_attributes_for :user_languages


	# ファイルアップロード処理
	mount_uploader :image, ImageUploader


  def soft_delete
    update(deleted_at: Time.now)
  end

  #論理消去されたユーザーをログイン不可に
  def active_for_authentication?
    super && !deleted_at && (!confirmation_required? || confirmed? || confirmation_period_valid?)
  end
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

	# userがいなければfacebookアカウントでuserを作成するメソッド
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        # userモデルが持っているカラムをそれぞれ定義していく
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.remote_image_url = auth.info.image.gsub('http://','https://')
        user.uid = auth.uid
        user.provider = auth.provider

        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        user.skip_confirmation!
      end
    end
  end
end