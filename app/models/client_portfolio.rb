class ClientPortfolio < ApplicationRecord
	belongs_to :client

	# ファイルアップロード処理
	mount_uploader :image, ImageUploader

end