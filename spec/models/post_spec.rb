require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title and valid counters' do
    post = Post.new(title: 'Sample Post', comments_counter: 10, likes_counter: 20)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(comments_counter: 10, likes_counter: 20)
    expect(post).not_to be_valid
  end

  it 'is invalid with a long title' do
    post = Post.new(title: 'A' * 251, comments_counter: 10, likes_counter: 20)
    expect(post).not_to be_valid
  end
end