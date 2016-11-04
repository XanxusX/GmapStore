class AddReviewsCountToStore < ActiveRecord::Migration
  def change
    add_column :stores, :reviews_count, :integer, default: 0
  end
end
