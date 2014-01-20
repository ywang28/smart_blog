class User < ActiveRecord::Base
  has_many :photo
  has_many :comment

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :login, presence: true, uniqueness: { case_sensitive: false }
  
  def password_valid?(candidate_password)
  	self.password_digest == User.encrypt(candidate_password + self.salt.to_s)
  end

  def User.encrypt(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  def password
  	self.password_digest
  end

  def password=(password)
	self.salt = Random.new.rand(1..(1<<31))
	self.password_digest = User.encrypt(password + self.salt.to_s)
  end
end