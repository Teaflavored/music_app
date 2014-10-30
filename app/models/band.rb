# == Schema Information
#
# Table name: bands
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Band < ActiveRecord::Base
  validates :name, presence: true
  default_scope { order("created_at") }
  has_many :albums, dependent: :destroy
  has_many :tracks, through: :albums, source: :tracks
end
