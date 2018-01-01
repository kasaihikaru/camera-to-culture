Rails.application.routes.draw do
	scope '(:locale)', constraints: { locale: /\w{2}/ } do

		devise_for :users, :controllers => {
			:registrations => "users/registrations"
		}
		root to: "homes#show"

		resource :home, only: [:show]

		resources :users, only: [:show] do
			resources :messages, only: [:index, :create]
			resources :events, only: [:index]
		end

		resources :clients, only: [:index, :show, :edit, :update]

		resources :customers, only: [:show, :edit, :update]

		resources :events, only: [:new, :create, :show] do
			resources :event_states, only: [:new, :create]
		end

	end
end