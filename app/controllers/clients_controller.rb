class ClientsController < ApplicationController
	before_action :user_check, only: :edit
	before_action :consent_check, only: :edit
	before_action :active_consent_check, only: :show

	def index
		import_current_user

		# 検索結果(.uniqするとarrayになってしまうので、kaminariは別に切り出す必要がある。)
		array_cls = Client.active.consent.registerd.intro_present.includes({user: [user_languages: :language]}, :client_portfolios).fits_categpory_id_in(params[:category_ids]).fits_prefecture_id_in(params[:prefecture_ids]).uniq
		@cls = Kaminari.paginate_array(array_cls).page(params[:page]).per(12)

		@locale = params[:locale]
	end

	def show
		import_current_user

		@cl_here = Client.find(id_params)
		@categories = @cl_here.client_categories.includes(:category)
		@langs = @cl_here.user.user_languages.includes(:language)
		@locations = @cl_here.client_locations.includes(:prefecture)
		@prim_price = @cl_here.client_primary_prices.active.first
		@options = @cl_here.client_option_prices.active
		@portfolios = @cl_here.client_portfolios.active.limit(20)
		@events = @cl_here.events.past.cs_reviewed.order(start_time: :DESC).includes(:event_review, customer: :user)
		@events_3 = @events.take(3)
		@ev_nums = @events.count()


		######### カレンダー ###########
		@day = Date.today

		from_date = Date.new(@day.year, @day.month, @day.beginning_of_month.day).beginning_of_week(:sunday)
		to_date = Date.new(@day.year, @day.month, @day.end_of_month.day).end_of_week(:sunday)

		# カレンダーを書く用
		@c_dates = []
		(from_date..to_date).each do |d|
			sch = ClientSchedule.find_by(client_id: @cl_here.id, date: d)

			date = {}
			date["date"] = d
			if sch.present?
				date["schedule"] = sch.schedule
			end
			@c_dates << date
		end

		@locale = params[:locale]
	end

	def edit
		import_current_user
		langs = @user.user_languages
		@lang_ids = []
		for lang in langs
			@lang_ids << lang.language_id
		end
		@cl_prim_price = @cl.client_primary_prices.active.first
		@cl_opt_prices = @cl.client_option_prices.active
		@cl_locations = @cl.client_locations
		@prefecture_ids = []
		for cl_location in @cl_locations
			@prefecture_ids << cl_location.prefecture_id
		end
		@cl_categories = @cl.client_categories
		@category_ids = []
		for cl_category in @cl_categories
			@category_ids << cl_category.category_id
		end
	end

	def update
		#-----クライアントupdate-----#
		cl = current_user.client
		cl.update(cl_create_params)
		client_id = cl.id

		#-----撮影価格登録------#
		pre_cl_prim_price = cl.client_primary_prices.active.first
		# 有効なレコードがなければ、単純に作成
		if pre_cl_prim_price.nil?
			ClientPrimaryPrice.create(client_id: client_id, price_per_hour: cl_prim_price_params[:price_per_hour].to_i, minimum_hours: cl_prim_price_params[:minimum_hours].to_i)

		# あれば、更新
		else
			#元の内容から変更があれば、変更する
			unless pre_cl_prim_price[:price_per_hour] == cl_prim_price_params[:price_per_hour].to_i && pre_cl_prim_price[:minimum_hours] == cl_prim_price_params[:minimum_hours].to_i

				#元のレコードのdeleted_at: Time.nowに
				pre_cl_prim_price.update(deleted_at: Time.now)

				#新しくレコードとして追加
				ClientPrimaryPrice.create(client_id: client_id, price_per_hour: cl_prim_price_params[:price_per_hour].to_i, minimum_hours: cl_prim_price_params[:minimum_hours].to_i)
			end
		end

		#-----オプション価格登録------#
		#消去
		if inact_cl_option_price_params.present?
			for id in inact_cl_option_price_params
				inact_opt_price = ClientOptionPrice.find(id)
				inact_opt_price.update(deleted_at: Time.now)
			end
		end

		#作成
		for opt_price in cl_option_price_params
			ClientOptionPrice.create(client_id: client_id, name: opt_price[:name], along_with_time: opt_price[:along_with_time], price: opt_price[:price].to_i)
		end

		#-----カテゴリ登録------#
		# 元々のカテゴリ
		cl_categories = cl.client_categories
		pre_category_ids = []
		for pre_category in cl_categories
			pre_category_ids << pre_category.category_id
		end

		#パラムス
		category_ids = cl_category_params


		if category_ids.present?
			# カテゴリ追加
			category_ids.each do |id|
				unless pre_category_ids.include?(id.to_i)
					ClientCategory.create(client_id: client_id, category_id: id)
				end
			end

			#カテゴリ消去
			pre_category_ids.each do |pre_id|
				unless category_ids.include?(pre_id.to_s)
					ClientCategory.where(client_id: client_id, category_id: pre_id.to_i).destroy_all
				end
			end
		end


		#-----エリア登録------#
		# 元々のエリア
		cl_locations = cl.client_locations
		pre_prefecture_ids = []
		for pre_location in cl_locations
			pre_prefecture_ids << pre_location.prefecture_id
		end

		#パラムス
		prefecture_ids = cl_prefecture_params


		if prefecture_ids.present?
			# エリア追加
			prefecture_ids.each do |id|
				unless pre_prefecture_ids.include?(id.to_i)
					ClientLocation.create(client_id: client_id, country_id: 1, prefecture_id: id)
				end
			end

			#エリア消去
			pre_prefecture_ids.each do |pre_id|
				unless prefecture_ids.include?(pre_id.to_s)
					ClientLocation.where(client_id: client_id, prefecture_id: pre_id.to_i).destroy_all
				end
			end
		end

		if cl.client_portfolios.active.present?
			flash[:alert] = t(".Setting_has_updated")
			redirect_to edit_user_client_path(current_user, cl)
		else
			redirect_to new_client_client_portfolio_path(cl)
		end
	end

	def pre_month
		@day = date_params
		@cl_here = cl_here_params.to_i

		from_date = Date.new(@day.year, @day.month, @day.beginning_of_month.day).beginning_of_week(:sunday)
		to_date = Date.new(@day.year, @day.month, @day.end_of_month.day).end_of_week(:sunday)

		# カレンダーを書く用
		@c_dates = []
		(from_date..to_date).each do |d|
			sch = ClientSchedule.find_by(client_id: @cl_here, date: d)

			date = {}
			date["date"] = d
			if sch.present?
				date["schedule"] = sch.schedule
			end
			@c_dates << date
		end
	end

	def next_month
		@day = date_params
		@cl_here = cl_here_params.to_i

		from_date = Date.new(@day.year, @day.month, @day.beginning_of_month.day).beginning_of_week(:sunday)
		to_date = Date.new(@day.year, @day.month, @day.end_of_month.day).end_of_week(:sunday)

		# カレンダーを書く用
		@c_dates = []
		(from_date..to_date).each do |d|
			sch = ClientSchedule.find_by(client_id: @cl_here, date: d)

			date = {}
			date["date"] = d
			if sch.present?
				date["schedule"] = sch.schedule
			end
			@c_dates << date
		end
	end




private
	def id_params
		params[:id]
	end

	def cl_here_params
		params[:cl_here]
	end

	def cl_create_params
		params.require(:client).permit(:camera, :deliverables, :message, :image).merge(user_id: current_user.id, introduction_ja: params[:introduction_ja], introduction_en: params[:introduction_en],introduction_zh: params[:introduction_zh],introduction_tw: params[:introduction_tw])
	end

	def cl_prim_price_params
		hash = {}
		hash[:price_per_hour] = params[:price_per_hour].to_i
		hash[:minimum_hours] = params[:minimum_hours].to_i
		return hash
	end

	def cl_option_price_params
		array = []
		for x in ["a","b","c","d","e"] do
			if params["name_"+x].present? && params["price_"+x].present?
				hash = {}
				hash[:name] = params["name_"+x]
				hash[:price] = params["price_"+x]
				if params["along_with_time_"+x] == "true"
					hash[:along_with_time] = "true"
				else
					hash[:along_with_time] = "false"
				end
				array << hash
			end
		end
		return array
	end

	def inact_cl_option_price_params
		params[:delete_opt_price]
	end

	def cl_prefecture_params
		params[:prefecture_id]
	end

	def cl_category_params
		params[:category_id]
	end

	def date_params
		Date.strptime(params[:day], '%Y-%m-%d')
	end

	def user_check
		unless user_signed_in? && params[:user_id].to_i == current_user.id
			flash[:alert] = t(".Please_login")
			redirect_to root_path
		end
	end

	def consent_check
		cl = Client.find(params[:id])
		unless cl.consent == true && cl.deleted_at == nil
			flash[:alert] = t(".The_page_does_not_exist")
			redirect_to root_path
		end
	end

	def active_consent_check
		cl = Client.find(params[:id])
		unless cl.consent == true && cl.confirmed == true && cl.deleted_at == nil && cl.client_primary_prices.active.first.price_per_hour.present?
			flash[:alert] = t(".The_page_does_not_exist")
			redirect_to root_path
		end
	end

end