class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  attr_accessor :password, :password_confirmation
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  before_save :encrypt
  
  def encrypt
    if password.present? 
      self.password_salt = BCrypt::Engine.generate_salt()
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end
  
end
