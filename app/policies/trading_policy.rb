class TradingPolicy < ApplicationPolicy

def index?
  # Admins, ClientAdmins, and CustomerAdmins can index customers (see Scope class for filters)
  @user.has_role? :admin or @user.has_role? :client_admin or @user.has_role? :customer_admin
end

def show?
  # Admins, ClientAdmins, and CustomerAdmins can see any customer details
  @user.has_role? :admin or @user.has_role? :client_admin or @user.has_role? :customer_admin
end

def update?
  # Only Admins and ClientAdmins can update customer details
  @user.has_role? :admin  or @user.has_role? :client_admin
end

def destroy?
  @user.has_role? :admin or @user.has_role? :client_admin
end

class Scope < Struct.new(:user, :scope)
  def resolve
    if (user.has_role? :admin or user.has_role? :client_admin)
      # Admins and ClientAdmins can see all Customers
      scope.where(:parent_id => nil)
    elsif user.has_role? :customer_admin
      # Customer Admins can only see their own Customer
      scope.where(:id => user.customer) # THIS DOES NOT APPEAR TO GET INVOKED BY THE SHOW METHOD OF THE CONTROLLER
    end
  end

  def show?
    # NOT SURE WHAT TO PUT IN HERE
  end
end
end