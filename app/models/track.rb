# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  album_id   :integer          not null
#  track_type :string(255)      not null
#  lyrics     :text
#

class Track < ActiveRecord::Base
  TRACK_TYPES = ["bonus", "regular"]
  validates :track_type, :album, :name, presence: true
  validates :track_type, inclusion: { in: TRACK_TYPES }
  
  belongs_to :album
  has_one :band, through: :album, source: :band
end
