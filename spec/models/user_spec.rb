require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Richard', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Brazil.') }

  before { subject.save }

  it 'should be valid with valid attributes' do    
    expect(subject).to be_valid
  end

  it 'should NOT be valid without a name' do 
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be initially set to zero' do    
    expect(subject.posts_counter).to be(0)
  end

  it 'should NOT be valid with a non-integer posts_counter' do 
    subject.posts_counter = 1.5
    expect(subject).to_not be_valid

    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'should NOT be valid with a posts_counter less than zero' do 
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'get_most_recent_posts should return an empty array if the user didn\'t created any posts' do
    recent_posts = subject.get_most_recent_posts
    expect(recent_posts.length).to be(0)
  end

  it 'get_most_recent_posts should return the most recent posts created by the user' do
    NUM_POSTS_CREATED = 5
    NUM_RECENT_POSTS = 3
    posts_created = []

    NUM_POSTS_CREATED.times do
      posts_created << Post.create(title: 'testing', author: subject, text: 'testing')
    end

    expect(subject.get_most_recent_posts.length).to be(NUM_POSTS_CREATED)

    recent_posts = posts_created[NUM_RECENT_POSTS - 1..-1].reverse

    expect(subject.get_most_recent_posts(NUM_RECENT_POSTS)).to eq(recent_posts)
  end
end