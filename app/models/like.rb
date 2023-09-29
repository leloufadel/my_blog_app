class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def update_post_likes_counter
    post.update(likesCounter: post.likes.count)
  end
end
