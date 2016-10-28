class Review < ActiveRecord::Base
  belongs_to :store
  validates :comment,:rating, presence: true
end
