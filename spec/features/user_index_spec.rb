require 'rails_helper'

RSpec.feature 'User Index Page' do
  before(:each) do
    @user1 = create(:user, name: 'user1', photo: 'user1_profile_image.jpg', postsCounter: 0)
    @user2 = create(:user, name: 'user2', photo: 'user2_profile_image.jpg', postsCounter: 1)
  end
  scenario 'I can see the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end
  scenario 'I can see the profile picture for each user' do
    visit user_path(@user1)
    expect(page).to have_css('img[src*="user1_profile_image.jpg"]')
  end
  scenario 'I can see the number of posts of the user' do
    visit user_path(@user1)
    expect(page).to have_content(@user1.postsCounter)
  end
  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path
    user5 = User.find_by(name: 'user1')
    click_link user5.name
    expect(current_path).to eq(user_path(user5))
  end
end
