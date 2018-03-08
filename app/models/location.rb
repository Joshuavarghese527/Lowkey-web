class Location < ApplicationRecord
  enum instant: {Request: 0, Instant: 1}

  has_many :reservations

  has_many :photos
  validates :location_type, presence: true
  validates :accomodate, presence: true
  validates :lisiting_name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "170x75>"},
  source_file_options: { regular: "-density 96 -depth 8 -quality 100" },
                           convert_options: { medium: "-quality 80" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :reviews


 def average_rating
    reviews.blank? ? 0 : reviews.average(:star).round(2)
  end


end
