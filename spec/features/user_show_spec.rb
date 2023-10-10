# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.feature 'User Show Page' do
  before(:each) do
    @user1 = create(:user, name: 'Pikachu', bio: 'Pokemon', photo: 'https://www.pngegg.com/en/png-wgjix',
                           postsCounter: 0)
    @user2 = create(:user, name: 'Meowth', bio: 'Pokemon2', photo: 'https://www.pngegg.com/en/png-sigeb',
                           postsCounter: 0)
    @post1 = create(:post, author: @user1, title: 'Game 1', text: 'I won')
    @post2 = create(:post, author: @user1, title: 'Game 2', text: 'I lost')
    @post3 = create(:post, author: @user1, title: 'Game 3', text: 'Draw')
    @post4 = create(:post, author: @user2, title: 'Game 4', text: 'difficult')
    @post5 = create(:post, author: @user2, title: 'Game 5', text: 'awesome')
    @post6 = create(:post, author: @user2, title: 'Game 6', text: 'Fire')
    visit user_path(@user1)
  end

  scenario 'I can see the username, bio, and profile picture of the user' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user1.bio)
    expect(page).to have_css('img[src*="https://www.pngegg.com/en/png-wgjix"]')
  end

  scenario 'I can see the number of posts of the user' do
    expect(page).to have_content(@user1.postsCounter)
  end

  scenario 'I can see a button to view user\'s posts' do
    expect(page).to have_link('See All Posts', href: user_posts_path(@user1))
  end

  scenario 'I can see the titles of the first 3 posts of the user' do
    expect(page).to have_text(@post1.title)
    expect(page).to have_text(@post2.title)
    expect(page).to have_text(@post3.title)
    expect(page).not_to have_text(@post4.title)
    expect(page).not_to have_text(@post5.title)
    expect(page).not_to have_text(@post6.title)
  end

  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    click_link 'See All Posts'
    expect(current_path).to eq(user_posts_path(@user1))
  end
end
# rubocop:enable Metrics/BlockLength
