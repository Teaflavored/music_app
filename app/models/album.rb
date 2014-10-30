# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  name       :string(255)      not null
#  album_type :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  ALBUM_TYPES = ["live", "studio"]
  validates :name, :album_type, :band, presence: true
  validates :album_type, inclusion: { in: ALBUM_TYPES }
  
  belongs_to :band
  has_many :tracks, dependent: :destroy
end
