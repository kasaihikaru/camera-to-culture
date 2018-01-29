class Message < ApplicationRecord

	scope :user_sends, -> id { where(sender_id: id)}
	scope :user_recirves, -> id { where(reciever_id: id) }
	scope :order_new, -> { order("created_at DESC") }
	scope :order_old, -> { order("created_at ASC") }

	# scope :user_sends, -> id { where(sender_id: id).group(:sender_id)}
	# scope :user_recirves, -> id { where(reciever_id: id).group(:reciever_id) }

end