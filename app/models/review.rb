class Review < ActiveRecord::Base
  belongs_to :store, counter_cache: :reviews_count
  belongs_to :author, class_name: "User", foreign_key: :user_id
  validates :comment,:rating, presence: true

  def editable_by?(user)
    user && user == author
  end
end
