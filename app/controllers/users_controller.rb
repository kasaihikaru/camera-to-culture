class UsersController < ApplicationController
	# before_action :authenticate_user!, only: :show
	before_action :user_check, only: :show

	def show
		#user_info
		@user = current_user
		langs = @user.user_languages.includes(:language)
		@mylangs = []
		langs.each do |lang|
			@mylangs << lang.language
		end

		#client_info
		@cl = @user.clients.active.first
		@cl_categories = @cl.client_categories.includes(:category)
		@cl_prim_price = @cl.client_primary_prices.active.first
		@cl_opt_prices = @cl.client_option_prices.active
		@cl_locations = @cl.client_locations.includes(:prefecture)
		@cl_prefectures = []
		for cl_locations in @cl_locations
			@cl_prefectures << cl_locations.prefecture
		end
		@portfolio_nums = @cl.client_portfolios.active.count

		#schedule.present?
		@cl_schedules = @cl.client_schedules.future.available

		#customer_info
		@cs = @user.customers.active.first

		#event
		cl_evs = @cl.events.includes(customer: :user)
		cl_evs_future = cl_evs.future
		@cl_future = []
		for ev in cl_evs_future do
			if ev.event_states.last.state == "request"
				@cl_future << ev.event_states.last
			end
		end
		cl_evs_past = cl_evs.past
		@cl_past = []
		for ev in cl_evs_past do
			if ev.event_states.last.state.in?(['cl_accepted','cs_accepted'])
				@cl_past << ev.event_states.last
			end
		end

		cs_evs = @cs.events.includes(client: :user)
		cs_evs_future = cs_evs.future
		@cs_future = []
		for ev in cs_evs_future do
			if ev.event_states.last.state == "cl_edited"
				@cs_future << ev.event_states.last
			end
		end
		cs_evs_past = cs_evs.past
		@cs_past = []
		for ev in cs_evs_future do
			if ev.event_states.last.state == "cl_delivered"
				@cs_future << ev.event_states.last
			end
		end
	end

	def profile
		# menu用
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first

		# content用
		user_languages = current_user.user_languages
		@lang_ids = []
		for user_language in user_languages
			@lang_ids << user_language.language_id
		end
	end

	def edit_profile
		# imageの更新
		if edit_profile_params.present?
			current_user.update(edit_profile_params)
		end

		#User_languageの更新
		unless user_language_params == nil
			#元のlangを取得
			pre_user_languages = current_user.user_languages
			pre_lang_ids = []
			for user_language in pre_user_languages
				pre_lang_ids << user_language.language_id
			end

			#変更するlangと照らし合わせて更新
			language_ids = user_language_params
			language_ids.each do |id|
				unless pre_lang_ids.include?(id.to_i)
					UserLanguage.create(user_id: current_user.id, language_id: id.to_i)
				end
			end
			pre_lang_ids.each do |pre_id|
				unless language_ids.include?(pre_id.to_s)
					UserLanguage.where(user_id: current_user.id, language_id: pre_id.to_i).destroy_all
				end
			end
		end

		# 自己紹介の更新
		current_user.customers.active.first.update(introduction: cs_intro_params)

		flash[:alert] = "更新しました"
		redirect_to profile_users_path
	end


private
	def user_language_params
		params[:language_id]
	end

	def edit_profile_params
		if params[:user].present?
			params.require(:user).permit(:image)
		end
	end

	def cs_intro_params
		params[:introduction]
	end

	def user_check
		unless user_signed_in? && params[:id].to_i == current_user.id
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end