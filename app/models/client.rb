class Client < ApplicationRecord

	scope :active, -> { where(deleted_at: nil) }
	scope :consent, -> { where(consent: true) }
	scope :registerd, -> { where.not(introduction: nil).where.not(image: nil).where(confirmed: true) }
	scope :cs_intro_present, ->  {
		joins(:user).merge(User.cs_intro_present)
	}

	belongs_to :user

	has_many :client_portfolios
	accepts_nested_attributes_for :client_portfolios
	has_many :client_locations
	has_many :client_categories
	has_many :client_schedules
	has_many :client_primary_prices
	has_many :client_option_prices
	has_many :client_contacts
	has_many :events
	has_many :client_reviews
	has_many :customer_reviews
	has_many :categories, through: :client_categories
	has_many :prefectures, through: :client_locations


	# ファイルアップロード処理
	mount_uploader :image, ImageUploader

#--------indexでの検索用------------
  #引数のcategoryのうちどれかにあてはまる
  scope :fits_categpory_id_in, -> category_ids {
    joins(:categories).merge(Category.id_in category_ids) if category_ids.present?
  }

  #引数のprefectureにあてはまる
  scope :fits_prefecture_id_in, -> prefecture_ids {
    joins(:prefectures).merge(Prefecture.id_in prefecture_ids)  if prefecture_ids.present?
  }


  def soft_delete
    update(deleted_at: Time.now)
  end


#--------photo search-------------
	def self.search(search) #ここでのself.はUser.を意味する
		if search
			where(['camera LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
		else
			all #全て表示。User.は省略
		end
	end

end