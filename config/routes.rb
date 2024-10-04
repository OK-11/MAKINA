Rails.application.routes.draw do

  root 'sessions#new'

  namespace :admin do
    resources :users do
      resources :projects do
        resources :project_missions do
          resources :project_mission_tasks
        end
      end
    end
    resources :missions
    resources :tasks
  end

  resource :sessions
  resources :users
  resources :project_missions

  get '/api/polling_mission' => 'api/pollings#polling_mission'
  get '/api/polling_task/:id' => 'api/pollings#polling_task'

end