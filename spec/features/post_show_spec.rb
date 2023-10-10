require 'rails_helper'

RSpec.feature 'Post Show Page' do
  before(:each) do
    @user1 = User.create(name: 'user1', bio: 'Teacher from Uganda', photo: 'user1_profile_image.jpg', postsCounter: 0)
    @user2 = User.create(name: 'User2')
    @post = Post.create(author_id: @user1.id, title: 'Hello', commentsCounter: 2, likesCounter: 1, text: 'Post body')
    @comment = Comment.create(user_id: @user2.id, post_id: @post.id, text: 'my comment')
  end

  scenario 'I can see the title of the post' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.title)
  end

  scenario 'I can see who wrote the post.' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@user1.name)
  end

  scenario 'I can see how many comments it has.' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.commentsCounter)
  end

  scenario 'I can see how many likes it has' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.likesCounter)
  end

  scenario 'I can see the post body' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.text)
  end

  scenario 'I can see the username of each commentor.' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@user2.name)
  end

  scenario 'I can see the comment each commentor left' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@comment.text)
  end
end
