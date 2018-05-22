class CategoriesController < ApplicationController

	def profile
		import_current_user
		@cls = Client.active.consent.registerd.cs_intro_present.includes(:user, :client_primary_prices, :client_portfolios).fits_categpory_id_in(1)
		@cls_kanto = @cls.fits_prefecture_id_in([8..15]).uniq
		@cls_kansai = @cls.fits_prefecture_id_in([25..30]).uniq
	end

	def id_photo
		import_current_user
	end

	def wedding
		import_current_user
	end

	def traveling
		import_current_user
	end

	def daily_life
		import_current_user
	end

	def seven_five_three
		import_current_user
	end

	def coming_of_age
		import_current_user
	end

	def maternity
		import_current_user
	end

	def new_born
		import_current_user
	end

	def commodities
		import_current_user
	end

	def event
		import_current_user
	end

	def pet
		import_current_user
	end




end
