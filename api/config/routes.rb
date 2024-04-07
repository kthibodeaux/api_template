# frozen_string_literal: true

Rails.application.routes.draw do
  root to: proc { [404, {}, []] }

  get 'health' => 'rails/health#show', as: :rails_health_check

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  post 'sign_in', to: 'sessions#create'
  post 'sign_up', to: 'registrations#create'

  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]

  namespace :identity do
    resource :email,              only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset,     only: %i[create update]
  end

  namespace :authentications do
    resources :events, only: :index
  end
end
