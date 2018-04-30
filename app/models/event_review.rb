class EventReview < ApplicationRecord

	belongs_to :event

	scope :cs_reviewed, -> { where.not(cs_review: nil) }

	# ファイルアップロード処理
	mount_uploader :cs_image_1, ImageUploader
	mount_uploader :cs_image_2, ImageUploader
	mount_uploader :cs_image_3, ImageUploader
	mount_uploader :cs_image_4, ImageUploader
	mount_uploader :cs_image_5, ImageUploader
	mount_uploader :cs_image_6, ImageUploader

end