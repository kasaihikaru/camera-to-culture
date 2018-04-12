class EventPhoto < ApplicationRecord
	belongs_to :event

	scope :active, -> { where(is_deleted: false) }
	scope :image_present, -> { where.not(image: nil) }
	scope :from_ev, -> event_id{ where(event_id: event_id) }

	# ファイルアップロード処理
	mount_uploader :image, ImageUploader
end