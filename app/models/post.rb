class Post < ActiveRecord::Base
  attr_accessible :link, :message, :user_id
  validates :message, :user_id, presence: true

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.sort_posts(posts)
    oldest_first = posts.sort_by do |post|
      post.created_at
    end

    newest_first = oldest_first.reverse
  end
end
