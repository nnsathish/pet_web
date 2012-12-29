require 'digest/sha1'
class User
  include MongoMapper::Document

  key :username, String, :required => true, :unique => true, :length => 6..10
  key :email, String, :required => true, :unique => true, :format => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  key :hashed_password, String
  key :salt, String
  key :extuid, String
  key :setup_complete, Boolean, :default => false

  attr_accessor :password, :password_confirmation

  validates :password, :confirmation => true, :presence => true, :length => 8..12, :on => :create

  has_one :budget, :dependent => :destroy
  has_many :user_expenses, :dependent => :destroy

  before_create :hash_password

  class << self
    def [](uname)
      return nil if uname.blank?
      self.find_by_username(uname)
    end
  end

  def login
    return self unless self.can_try_login?
    u = self.class[self.username]
    return add_error('Invalid username!') if u.nil?
    return add_error('Invalid password!') unless u.pass_match?(self.password)
    u
  end

  def register
    self.save
    self
  end

  def hash_password(pass = nil)
    self.salt ||= generate_rand
    pass ||= self.password
    self.hashed_password = Digest::SHA1.hexdigest(pass, self.salt)
  end

  def pass_match?(pass)
    self.hashed_password == self.hash_password(pass)
  end

  def can_try_login?
    self.errors.add_on_blank([:username, :password])
    self.errors.empty?
  end

private

  def generate_rand(length = 8)
    ActiveSupport::SecureRandom.base64(length)
  end

  def add_error(msg)
    self.errors.add(:base, msg)
    self
  end
end
