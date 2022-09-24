require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    fake_user = User.new(name: 'User Test', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Teacher from Brazil.')
    fake_post = Post.create(title: 'testing', author: fake_user, text: 'testing')
    Like.new(author: fake_user, post: fake_post)
  end

  before { subject.save }

  it 'should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should NOT be valid with an invalid author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should NOT be valid with an invalid post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end
