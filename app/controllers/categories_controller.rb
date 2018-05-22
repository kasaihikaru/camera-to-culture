class CategoriesController < ApplicationController

	def profile
		import_current_user
		cate_cl_search(1)
		area_cl_search
		area_cl_search
	end

	def id_photo
		import_current_user
		cate_cl_search(2)
		area_cl_search
	end

	def wedding
		import_current_user
		cate_cl_search(3)
		area_cl_search
	end

	def traveling
		import_current_user
		cate_cl_search(4)
		area_cl_search
	end

	def daily_life
		import_current_user
		cate_cl_search(5)
		area_cl_search
	end

	def seven_five_three
		import_current_user
		cate_cl_search(6)
		area_cl_search
	end

	def coming_of_age
		import_current_user
		cate_cl_search(7)
		area_cl_search
	end

	def maternity
		import_current_user
		cate_cl_search(8)
		area_cl_search
	end

	def new_born
		import_current_user
		cate_cl_search(9)
		area_cl_search
	end

	def commodities
		import_current_user
		cate_cl_search(10)
		area_cl_search
	end

	def event
		import_current_user
		cate_cl_search(11)
		area_cl_search
	end

	def pet
		import_current_user
		cate_cl_search(12)
		area_cl_search
	end




end
