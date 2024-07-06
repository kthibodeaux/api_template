# frozen_string_literal: true

class Admin::LinkPolicy < ApplicationPolicy
  def index?
    user.admin?
  end
end
