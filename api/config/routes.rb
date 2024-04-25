# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'roots#index'

  get 'health' => 'rails/health#show', as: :rails_health_check

  mount GoodJob::Engine => 'good_job'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  post 'sign_in', to: 'sessions#create'
  post 'sign_up', to: 'registrations#create'

  resources :sessions, only: %i[index show destroy]

  namespace :admin do
    resources :links, only: :index
  end

  namespace :identity do
    resource :current, only: %i[show]
    resource :attributes, only: %i[edit update]
    resource :email_verification, only: %i[create update]
    resource :password_reset, only: %i[create update]
  end
end
