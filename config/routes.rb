Rails.application.routes.draw do

	devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

	scope '(:locale)', constraints: { locale: /\w{2}/ } do

		devise_for :users, skip: :omniauth_callbacks, :controllers => {
			registrations: "users/registrations",
			sessions: "users/sessions",
			passwords: "users/passwords",
			confirmations: "users/confirmations",
			unlocks: "users/unlocks",
			mailer: "users/mailer"
		}

		root to: "homes#show"

		resource :home, only: [:show]

		resources :users, only: [:show] do
			collection do
				get 'profile'
				put 'edit_profile'
				get 'account_setting'
				put 'inactive_account'
			end
			resources :messages, only: [:index, :new, :create, :show] do
				collection do
					post 'first_create'
				end
			end
			resources :clients, only: [:edit, :update] do
				resources :client_contacts, only: [:new, :create] do
					collection do
						get 'first_new'
						post 'first_create'
					end
				end
				resources :client_schedules, only: [:index, :create] do
					collection do
						delete 'r_destroy'
					end
				end
			end
		end

		resources :clients, only: [:index, :show] do
			collection do
				get 'pre_month'
				get 'next_month'
			end
			resources :client_portfolios, only: [:new, :create] do
				collection do
					delete 'r_destroy'
				end
			end
		end

		resources :customers, only: [:show]

		resources :events, only: [:new, :create, :show, :edit, :update] do
			collection do
				get 'cs_past'
				get 'cs_future'
				get 'cl_past'
				get 'cl_future'
			end
			resources :event_states, only: []  do
				collection do
					post 'cl_accept'
					post 'cl_deliver'
					post 'cs_recieve'
					post 'cl_edit'
					post 'cs_accept'
					post 'cl_dismiss'
					post 'cs_dismiss'
					post 'cs_cancele'
					post 'cs_request_cancele'
					post 'cl_cancele'
				end
			end
			resources :event_photos, only: [:create] do
				collection do
					delete 'r_destroy'
					get 'zip_dl'
				end
			end
			resources :event_reviews, only: [:create, :update]
		end

		resource :about, only: [:show] do
			collection do
				get 'terms_of_service_cl'
				get 'terms_of_service_cs'
				get 'to_be_a_cameraman'
				get 'how_to_use'
				get 'use_with_phone'
				get 'contact_us'
			end
		end

		resources :categories, only: [:index] do
			collection do
				get 'profile'
				get 'id_photo'
				get 'wedding'
				get 'traveling'
				get 'dairy_life'
				get 'seven_five_three'
				get 'coming_of_age'
				get 'maternity'
				get 'new_born'
				get 'commodities'
				get 'event'
				get 'pet'
			end
		end
	end
end