# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.feature 'User Post Index Page' do
  context 'when viewing the post index page' do
    let!(:user) { create(:user, name: 'test_user', bio: 'this is bio', photo: 'user1.jpg') }
    let!(:user_comment) { create(:user, name: 'John', bio: 'this is bio', photo: 'John.jpg') }
    let!(:post1) { create(:post, author: user, title: 'Post 1', text: 'this is body of a post') }
    let!(:post2) { create(:post, author: user, title: 'Post 2', text: 'Body 2') }
    let!(:comment1) { create(:comment, post: post1, text: 'Comment 1', author: user_comment) }
    let!(:comment2) { create(:comment, post: post1, text: 'Comment 2', author: user_comment) }
    let!(:comment3) { create(:comment, post: post1, text: 'Comment 3', author: user_comment) }
    let!(:comment4) { create(:comment, post: post1, text: 'Comment 4', author: user_comment) }
    let!(:comment5) { create(:comment, post: post1, text: 'Comment 5', author: user_comment) }
    let!(:comment6) { create(:comment, post: post1, text: 'Comment 6', author: user_comment) }

    scenario 'displays user profile information' do
      visit user_posts_path(user)
      expect(page).to have_css("img[src*='#{user.photo}']")
      expect(page).to have_content(user.name)
      expect(page).to have_content("Number of posts: #{user.postsCounter}")
    end

    scenario 'displays only 5 recent comments' do
      visit user_posts_path(user)
      expect(page).to have_content('Comment 6')
      expect(page).to have_content('Comment 5')
      expect(page).to have_content('Comment 4')
      expect(page).to have_content('Comment 3')
      expect(page).to have_content('Comment 2')
      expect(page).not_to have_content('Comment 1')
    end

    scenario 'displays part of the body' do
      visit user_posts_path(user)
      expect(page).to have_content('this is body of a post')
    end

    scenario 'displays title of the post correctly' do
      visit user_posts_path(user)
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
    end
  end
end
# rubocop:enable Metrics/BlockLength
