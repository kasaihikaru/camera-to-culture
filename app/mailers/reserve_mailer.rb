class ReserveMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reserve_mailer.cs_requested.subject
  #
  def cs_requested(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link)
		@message = message
		@day = day
		@wday = wday
		@start_time = start_time
		@end_time = end_time
		@prefecture = prefecture
		@location_detail = location_detail
		@num_people = num_people
		@total_price = total_price
		@primary_price_sum = primary_price_sum
		@options = options
		@reciever_mail = reciever_mail
		@sender_name = sender_name
		@link = link

		mail(
			to: @reciever_mail,
			subject: t(".ctoc") + @sender_name + t(".title"),
		)
	end

	def ev_state_changed(message, day, wday, start_time, end_time, prefecture, location_detail, num_people, total_price, primary_price_sum, options, reciever_mail, sender_name, link, state)
		@message = message
		@day = day
		@wday = wday
		@start_time = start_time
		@end_time = end_time
		@prefecture = prefecture
		@location_detail = location_detail
		@num_people = num_people
		@total_price = total_price
		@primary_price_sum = primary_price_sum
		@options = options
		@reciever_mail = reciever_mail
		@sender_name = sender_name
		@link = link
		@state = state

		if @state == "cl_accepted"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cl_accept_titl_titlee"),
			)
		elsif @state == "cl_delivered"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cl_cl_delivere_titled"),
			)
		elsif @state == "cl_dismissed"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cl_dismissed_title"),
			)
		elsif @state == "cl_canceled"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cl_canceled_title"),
			)
		elsif @state == "cs_accepted"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cs_accepted_title"),
			)
		elsif @state == "cs_dismissed"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cs_dismissed_title"),
			)
		elsif @state == "cs_request_canceled"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cs_request_canceled_title"),
			)
		elsif @state == "cs_canceled"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cs_canceled_title"),
			)
		elsif @state == "cs_recieved"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cs_recieve_title"),
			)
		elsif @state == "cl_edited"
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".cl_edited_title"),
			)
		else
			mail(
				to: @reciever_mail,
				subject: t(".ctoc") + @sender_name + t(".else_title"),
			)
		end
	end

end
