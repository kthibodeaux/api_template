# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'roots#index'

  get 'health' => 'rails/health#show', as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # rails_admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post 'sign_in', to: 'sessions#create'
  post 'sign_up', to: 'registrations#create'

  resources :sessions, only: %i[index show destroy]

  namespace :identity do
    resource :email, only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password, only: %i[edit update]
    resource :password_reset, only: %i[create update]
  end
end
