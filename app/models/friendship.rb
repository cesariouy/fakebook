class Friendship < ActiveRecord::Base
  attr_accessible :user1_id, :user2_id
  validates :user1_id, :user2_id, presence: true
  validates :user1_id, uniqueness: {scope: :user2_id}

  belongs_to(
    :user1,
    class_name: "User",
    foreign_key: :user1_id,
    primary_key: :id
  )
  belongs_to(
    :user2,
    class_name: "User",
    foreign_key: :user2_id,
    primary_key: :id
  )

  def create_two_friendships
    complement = Friendship.new(
      user1_id: self.user2_id,
      user2_id: self.user1_id
    )

    transaction do
      self.save
      complement.save
    end
  end

  def destroy_two_friendships
    complement = Friendship.find_by_user1_id_and_user2_id(
      self.user2_id,
      self.user1_id
    )

    transaction do
      complement.destroy
      self.destroy
    end
  end
end
