class ReviewsController < ApplicationController
  before_action :find_store

  def new
    @review = @store.reviews.new
  end

  def create
    @review = @store.reviews.build(review_params)
    if @review.save
      redirect_to store_path(@store), notice: "Successed!"
    else
      render :new
    end
  end

  def edit
    @review = @store.reviews.find(params[:id])
  end

  def update
    @review = @store.reviews.find(params[:id])

    if @review.update(review_params)
      redirect_to store_path(@store), notice: "Successed!"
    else
      render :edit
    end
  end

  def destroy
    @review = @store.reviews.find(params[:id])
    @review.destroy
    redirect_to store_path(@store), alert: "Deleted!"
  end

  private

  def find_store
    @store = Store.find(params[:store_id])
  end

  def review_params
    params.require(:review).permit(:rating,:comment,:store_id)
  end
end
