class ClientSchedulesController < ApplicationController
before_action :user_check, only: [:index, :create, :r_destroy]


	def index
		@user = current_user
		@cl = @user.clients.active.first
		@cs = @user.customers.active.first


		######### カレンダー ###########
		@day = date_params

		from_date = Date.new(@day.year, @day.month, @day.beginning_of_month.day)
		to_date = Date.new(@day.year, @day.month, @day.end_of_month.day)

		# カレンダーを書く用
		@c_dates = []
		(from_date..to_date).each do |d|
			sch = ClientSchedule.find_by(client_id: @cl.id, date: d)

			date = {}
			date["date"] = d
			if sch.present?
				date["schedule"] = sch.schedule
			end
			@c_dates << date
		end

	end

	def create
		schedule_params.each { |date, sch|
			x = ClientSchedule.find_by(client_id: client_params.to_i, date: Date.strptime(date, '%Y-%m-%d'))
			if x.present?
				x.update(schedule: sch)
			else
				ClientSchedule.create(client_id: client_params.to_i, date: Date.strptime(date, '%Y-%m-%d'), schedule: sch)
			end
		}

		redirect_to user_client_client_schedules_path(user_params, client_params, day: date_params)
	end

	def r_destroy
	end


#------ストロングパラメーター------#
private

	def date_params
		Date.strptime(params[:day], '%Y-%m-%d')
	end

	def user_params
		params[:user_id]
	end

	def client_params
		params[:client_id]
	end

	def schedule_params
		params[:sch].first
	end

	def r_destroy_params
		# params[:delete_portfolio]
	end


	def user_check
		unless user_signed_in? && Client.find(params[:client_id]).user == current_user
			flash[:alert] = "ログインしてください"
			redirect_to root_path
		end
	end
end