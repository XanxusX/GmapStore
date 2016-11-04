class Account::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = current_user.reviews.order("updated_at DESC")
  end
end
