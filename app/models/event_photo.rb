class EventPhoto < ApplicationRecord
	belongs_to :event

	scope :active, -> { where(is_deleted: false) }

	# ファイルアップロード処理
	mount_uploader :image, ImageUploader
end