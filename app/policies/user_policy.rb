class UserPolicy < ApplicationPolicy

    def show?
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
            if user.admin?
                scope.all
            elsif user.subscriber?

            else
                scope.none
            end
        end
    end

end