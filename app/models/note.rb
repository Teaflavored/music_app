# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Note < ActiveRecord::Base
  validates :user, :track, :body, presence: true
  
  belongs_to :user
  belongs_to :track
end
