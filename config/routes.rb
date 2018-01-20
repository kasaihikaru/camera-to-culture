Rails.application.routes.draw do

	devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

	scope '(:locale)', constraints: { locale: /\w{2}/ } do

		devise_for :users, skip: :omniauth_callbacks, :controllers => { :registrations => "users/registrations"}

		root to: "homes#show"

		resource :home, only: [:show]

		resources :users, only: [:show] do
			resources :messages, only: [:index, :create]
			resources :events, only: [:index]
			resources :clients, only: [:edit, :update]
			resources :customers, only: [:edit, :update]
		end

		resources :clients, only: [:index, :show] do
			resources :client_portfolios, only: [:new, :create, :destroy]
		end

		resources :customers, only: [:show]

		resources :events, only: [:new, :create, :show] do
			resources :event_states, only: [:new, :create]
		end

	end
end