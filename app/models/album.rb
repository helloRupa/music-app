class Album < ApplicationRecord
  validates :band_id, :title, :year, presence: true
  validates :studio, inclusion: { in: [true, false], message: 'Boolean values only' }
  
  belongs_to :band

  has_many :tracks,
    dependent: :destroy
end