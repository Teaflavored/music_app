# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_reader :password
  validates :email, :session_token, presence: true
  validates :password_digest, presence: { message: "Password must be present" }
  validates :password, length: { minimum: 4, allow_nil: true }
  #need to ensure user can have password digest through password=
  #need to ensure user has valid session token when initialized
  after_initialize :ensure_session_token
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil?
    return nil unless user.is_password?(password)
    
    user  
  end
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def password=(password)
    #also allows for validating password length we can set ivar for password
    @password = password
    #user sets this when posting form, we have to set a pw digest in DB
    self.password_digest = BCrypt::Password.create(password)
    #doesn't need save that will be taken care of by controller
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    #changes database and sets a new session token for a user
    #used whenever the user logs in and out
    self.session_token = self.class.generate_session_token
    self.save!
  end
  private
  
    def ensure_session_token
      self.session_token ||= self.class.generate_session_token
    end
end
