class Store < ActiveRecord::Base
  validates :name, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  geocoded_by :address
  after_validation :geocode

  has_many :reviews, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  scope :recent, -> { order("updated_at DESC")}

  def editable_by?(user)
    user && user == owner
  end
end
