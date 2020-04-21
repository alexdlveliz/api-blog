class PostPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end
  
  def new?
    user_is_owner_of_record?
  end
  
  def create?
    user_is_owner_of_record?
  end

  def show?
    user_is_owner_of_record? || @record.published
  end
  
  def update?
    user_is_owner_of_record?
  end

  def category?
    true
  end

  private
  def user_is_owner_of_record?
    user.role == 'admin' || user.role == 'writer'
  end
end