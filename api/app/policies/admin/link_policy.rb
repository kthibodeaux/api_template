# frozen_string_literal: true

module Admin
  class LinkPolicy < ApplicationPolicy
    blueprint_authorize(
      fields: %i[name url icon],
      with: :index?
    )

    def index?
      user.admin?
    end
  end
end
