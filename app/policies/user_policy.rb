# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || user.id == record.id
  end

  def destroy?
    user.admin? || user.id == record.id
  end

  def update?
    user.admin? || user.id == record.id
  end

  def new?
    user.present?
  end

  def create?
    true
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return unless user.admin?

      scope.all

      user.subscriber?
      scope.none
    end
  end
end
