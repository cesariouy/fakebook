class User < ActiveRecord::Base
  attr_accessible :name, :password, :session, :username, :confirmation

  validates :password, length: {minimum: 6}
  validates :session, uniqueness: true
  validates :username, uniqueness: true

  after_initialize :require_session

  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many(
    :friendships,
    class_name: "Friendship",
    foreign_key: :user1_id,
    primary_key: :id
  )
  has_many(
    :friends,
    through: :friendships,
    source: :user2
  )

  def confirmation=(confirmation)
    @confirmation = confirmation
  end

  def password_confirmed?
    password == @confirmation
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.password == password ? user : nil
  end

  def self.generate_session
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session!
    self.session = User.generate_session
    self.save!
  end

  def require_session
    self.session ||= User.generate_session
  end

  def self.alphabetize_users
    User.all.sort_by do |user|
      user.name.downcase
    end
  end
end
