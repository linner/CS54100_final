class User < ActiveRecord::Base
  has_many :assignments
  has_many :questionnaires, :through => :assignments

  has_many :responses
  has_many :questions, :through => :responses

  attr_accessible :account_type, :name, :email, :password, :password_confirmation

  attr_accessor :password
  
  before_save :encrypt_password

  validates :email, :presence => true
  validates :password, :on => :create, :presence => true

  validates_uniqueness_of :email
  validates_confirmation_of :password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && (user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt))
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def is_admin?
    if self.account_type == "admin"
      true
    else
      false
    end
  end
end
