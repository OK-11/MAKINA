Rails.application.routes.draw do

  root 'sessions#new'

  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :projects, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :project_missions, only: [:new, :create, :show, :update, :destroy] do
          resources :project_mission_tasks, only: [:new, :create, :update, :destroy]
        end
      end
    end
    resources :missions, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create, :edit, :update]         
  resources :project_missions, only: [:show]
  
  resources :project_mission_tasks, only: [] do
    resources :comments, only: [:index, :create]
  end

  
  

  get '/api/polling_mission' => 'api/pollings#polling_mission'
  get '/api/polling_task/:id' => 'api/pollings#polling_task'
  get '/api/polling_user_notice' => 'api/pollings#user_notice'
  get '/notice/update/:id' => 'notices#update'

end