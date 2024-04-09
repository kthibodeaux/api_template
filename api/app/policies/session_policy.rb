# frozen_string_literal: true

class SessionPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.user == user
  end

  def create?
    !Current.user.present?
  end

  def destroy?
    record.user == user
  end
end
