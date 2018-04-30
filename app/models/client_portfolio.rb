class ClientPortfolio < ApplicationRecord

	scope :active, -> { where(deleted_at: nil) }

	belongs_to :client

	# ファイルアップロード処理
	mount_uploader :image, ImageUploader

end