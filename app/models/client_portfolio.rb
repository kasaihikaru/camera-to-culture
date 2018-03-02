class ClientPortfolio < ApplicationRecord

	scope :active, -> { where(is_deleted: false) }

	belongs_to :client

	# ファイルアップロード処理
	mount_uploader :image, ImageUploader

end