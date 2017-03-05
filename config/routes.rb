Rails.application.routes.draw do
  get 'smssenders/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    concern :searchable do
      collection do
        get 'search'
      end
    end

    get '/test', to: 'test#insecure'
    get '/test/insecure', to: 'test#insecure'
    get '/test/secured', to: 'test#secured'
    get '/test/markers', to: 'test#markers'

    resources :colors, only: [:index]
    resources :icons, only: [:index]
    resources :codes, only: [:create], concerns: [:searchable]

    resources :subscribers, only: [:create, :destroy], concerns: [:searchable]
  end

end
