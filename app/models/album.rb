class Album < ApplicationRecord
  validates :band_id, :title, :year, :studio, presence: true
  
  belongs_to :band
end