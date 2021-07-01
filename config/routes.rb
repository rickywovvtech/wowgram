Rails.application.routes.draw do
  devise_for :users
  root to: "wows#home"
  # resources :wows
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      resources :wows do
        collection do
          get 'home'
          get 'all_post'
          get 'userpost'
          get 'comment'
          post 'submit_comment'
          get 'follow'
          get 'unfollow'
        end
      end
    end
  end
end
