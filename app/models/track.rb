class Track < ApplicationRecord
  validates :album_id, :title, :ord, presence: true
  validates :ord, uniqueness: { scope: :album_id, message: 'A track number can only be used once per album' }

  belongs_to :album

  has_one :band,
    through: :album,
    source: :band

  has_many :notes
end
