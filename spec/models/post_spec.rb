require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    @fake_user = User.new(name: 'Richard', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Teacher from Brazil.')
    Post.create(title: 'testing', author: @fake_user, text: 'testing')
  end

  before { subject.save }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should NOT be valid with a non-existing author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should NOT be valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should NOT be valid with a title longer than 250 characters long' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be initially set to zero' do
    expect(subject.likes_counter).to be(0)
  end

  it 'likes_counter should be equal to the number of comments created' do
    num_likes_created = 3

    num_likes_created.times { Like.create(author: @fake_user, post: subject) }

    expect(subject.likes_counter).to be(num_likes_created)
  end

  it 'should NOT be valid with a non-integer likes_counter' do
    subject.likes_counter = 1.5
    expect(subject).to_not be_valid

    subject.likes_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'should NOT be valid with a likes_counter less than zero' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be initially set to zero' do
    expect(subject.comments_counter).to be(0)
  end

  it 'comments_counter should be equal to the number of comments created' do
    num_comments_created = 3

    num_comments_created.times { Comment.create(post: subject, author: @fake_user, text: 'testing') }

    expect(subject.comments_counter).to be(num_comments_created)
  end

  it 'should NOT be valid with a non-integer comments_counter' do
    subject.comments_counter = 1.5
    expect(subject).to_not be_valid

    subject.comments_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'should NOT be valid with a comments_counter less than zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'get_most_recent_comments should return an empty array if the user didn\'t created any posts' do
    recent_comments = subject.get_most_recent_comments
    expect(recent_comments.length).to be(0)
  end

  it 'get_most_recent_comments should return the most recent posts created by the user' do
    num_comments_created = 5
    num_recent_comments = 3
    comments_created = []

    num_comments_created.times do
      comments_created << Comment.create(post: subject, author: @fake_user, text: 'testing')
    end

    expect(subject.get_most_recent_comments.length).to be(num_comments_created)

    recent_comments = comments_created[num_recent_comments - 1..].reverse

    expect(subject.get_most_recent_comments(num_recent_comments)).to eq(recent_comments)
  end
end
