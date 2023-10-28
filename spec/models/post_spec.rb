require 'rails_helper'

RSpec.describe Post do
  before :all do
    @author = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Poland.')
  end

  it 'is invalid without title' do
    expect(Post.new(author: @author, text: 'Text here....', comments_counter: 0, likes_counter: 0)).to_not be_valid
  end

  it 'is valid with existing title' do
    expect(Post.new(author: @author, title: 'Kathy', text: 'Text here....', comments_counter: 0,
                    likes_counter: 0)).to be_valid
  end

  it 'is invalid with title exceeds 250' do
    expect(Post.new(author: @author, title: 'Kathy' * 250, text: 'Text here....', comments_counter: 0,
                    likes_counter: 0)).to_not be_valid
  end

  it 'is valid if comments_counter is integer' do
    expect(Post.new(author: @author, title: 'Kathy' * 250, text: 'Text here....', comments_counter: 'zero',
                    likes_counter: 0)).to_not be_valid
  end

  it 'is invalid if likes_counter is less than zero' do
    expect(Post.new(author: @author, title: 'Kathy' * 250, text: 'Text here....', comments_counter: 1,
                    likes_counter: -2)).to_not be_valid
  end

  context '#recent_comments' do
    before :all do
      @post = Post.create(author: @author, title: 'Kathy', text: 'Text here....', comments_counter: 0,
                          likes_counter: 0)
      8.times { |comment_i| Comment.create(user: @author, post: @post, text: (comment_i + 1).to_s) }
    end

    it 'returns five comments' do
      expect(@post.recent_comments.length).to eq 5
    end
  end

  context '#update_posts_counter' do
    before :all do
      8.times do
        Post.create(author: @author, title: 'Kathy', text: 'Text here....', comments_counter: 0,
                    likes_counter: 0)
      end
    end

    it 'keeps track of posts and equals 9' do
      expect(@author.posts_counter).to eq 9
    end
  end
end
