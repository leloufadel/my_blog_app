class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :commentsCounter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :likesCounter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
