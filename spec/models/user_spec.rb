require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      user = User.new(name: 'John Doe', posts_counter: 3)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with a negative posts_counter' do
      user = User.new(name: 'Alice', posts_counter: -1)
      expect(user).to_not be_valid
    end
  end
  describe '#recent_posts' do
    it 'returns the 3 most recent posts' do
      user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
      post1 = Post.create(author: user, title: 'Post 1', text: 'hello world', comments_counter: 0,
                          likes_counter: 0, created_at: 2.days.ago)
      post2 = Post.create(author: user, title: 'Post 2', text: 'hello world', comments_counter: 0,
                          likes_counter: 0, created_at: 2.days.ago)
      post3 = Post.create(author: user, title: 'Post 3', text: 'hello world', comments_counter: 0,
                          likes_counter: 0, created_at: 2.days.ago)
      rec_posts = user.recent_posts
      expect(rec_posts).to eq([post3, post2, post1])
    end
  end
end
