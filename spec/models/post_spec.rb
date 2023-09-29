require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:valid_author) { User.create(name: 'Test User') }

  it 'is valid with a title and valid counters' do
    post = Post.new(title: 'Sample', commentsCounter: 10, likesCounter: 20, author: valid_author)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(commentsCounter: 10, likesCounter: 20, author: valid_author)
    expect(post).not_to be_valid
  end

  it 'is invalid with a long title' do
    post = Post.new(title: 'A' * 251, commentsCounter: 10, likesCounter: 20, author: valid_author)
    expect(post).not_to be_valid
  end

  it 'is invalid with a negative commentsCounter' do
    post = Post.new(title: 'Sample', commentsCounter: -1, likesCounter: 20, author: valid_author)
    expect(post).not_to be_valid
  end

  it 'is invalid with a negative likesCounter' do
    post = Post.new(title: 'Sample', commentsCounter: 10, likesCounter: -1, author: valid_author)
    expect(post).not_to be_valid
  end

  it 'is valid with zero commentsCounter' do
    post = Post.new(title: 'Sample', commentsCounter: 0, likesCounter: 20, author: valid_author)
    expect(post).to be_valid
  end

  it 'is valid with zero likesCounter' do
    post = Post.new(title: 'Sample', commentsCounter: 10, likesCounter: 0, author: valid_author)
    expect(post).to be_valid
  end
end
