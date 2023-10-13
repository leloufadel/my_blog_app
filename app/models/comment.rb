class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :user
  belongs_to :post

  after_save :update_comments_counter
  after_destroy :update_comments_counter

  private

  def update_comments_counter
    post.update(commentsCounter: post.comments.count)
  end
end
