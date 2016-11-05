class Account::StoresController < ApplicationController
  before_action :authenticate_user!
  def index
    @stores = current_user.stores.recent
  end
end
