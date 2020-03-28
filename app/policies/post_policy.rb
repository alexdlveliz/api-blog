class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end
  
  def update?
    user.role == 'admin' || record.user == user
  end

  def create?
    user.role == 'admin' || user.role == 'writer'
  end
end