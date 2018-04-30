class EventPhoto < ApplicationRecord
	belongs_to :event

	scope :active, -> { where(deleted_at: nil) }
	scope :image_present, -> { where.not(image: nil) }
	scope :from_ev, -> event_id{ where(event_id: event_id) }

	# ファイルアップロード処理
	mount_uploader :image, ImageUploader
end