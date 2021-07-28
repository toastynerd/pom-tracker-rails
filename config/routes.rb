Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'front_end#index'

  namespace :api do
    namespace :v1 do
      resources :pomodoros
    end
  end
end
