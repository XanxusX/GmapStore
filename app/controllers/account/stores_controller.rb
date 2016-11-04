class Account::StoresController < ApplicationController
  before_action :authenticate_user!
  def index
    @stores = current_user.stores.order("updated_at DESC")
  end
end
