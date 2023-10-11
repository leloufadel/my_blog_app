# user index test

require 'rails_helper'

RSpec.feature 'User Index Page' do
  before(:each) do
    @user1 = create(:user, name: 'Pikachu', bio: 'Pokemon', photo: 'https://www.pngegg.com/en/png-wgjix',
                           postsCounter: 3)
    @user2 = create(:user, name: 'Meowth', bio: 'Pokemon2', photo: 'https://www.pngegg.com/en/png-sigeb',
                           postsCounter: 5)
    visit users_path
  end

  scenario 'I can see the username of all other users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  scenario 'I can see the profile picture for each user' do
    expect(page).to have_css("img[src*='https://www.pngegg.com/en/png-wgjix']")
    expect(page).to have_css("img[src*='https://www.pngegg.com/en/png-sigeb']")
  end

  scenario 'I can see the number of posts each user has written' do
    expect(page).to have_content("Number of posts: #{@user1.postsCounter}")
    expect(page).to have_content("Number of posts: #{@user2.postsCounter}")
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    click_link @user1.name
    expect(current_path).to eq(user_path(@user1))
  end
end
