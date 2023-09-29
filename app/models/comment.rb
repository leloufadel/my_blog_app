class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def update_post_comments_counter
    post.update(commentsCounter: post.comments.count)
  end
end
