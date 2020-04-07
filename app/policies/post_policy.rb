class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(published: true).or(scope.where(user_id: @user.try(:id)))
    end
  end

  def new?
    user.role == 'admin' || user.role == 'writer'
  end
  
  def create?
    user.role == 'admin' || user.role == 'writer'
  end

  def show?
    user_is_owner_of_record? || @record.published
  end
  
  def update?
    user_is_owner_of_record?
  end

  private
  def user_is_owner_of_record?
    user.role == 'admin' || user.role == 'writer'
    byebug
  end
end