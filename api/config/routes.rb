# frozen_string_literal: true

Rails.application.routes.draw do
  root to: proc { [404, {}, []] }

  get 'health' => 'health#show', as: :health_check
end
