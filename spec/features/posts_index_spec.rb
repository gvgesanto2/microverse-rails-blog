require 'rails_helper'

RSpec.describe 'User\'s posts index page', type: :feature do
  before(:each) do
    num_posts_created = 3

    @fake_user = User.create(
      name: 'Mr.Test',
      photo: 'test.png',
      bio: 'Testing...'
    )
    @posts = []

    num_posts_created.times do |i|
      post = Post.create(
        author: @fake_user,
        title: "Post - #{i}",
        text: "Post description test - " + ("#{i}" * 100)
      )
      @posts.push(post)
    end

    visit user_posts_path(@fake_user)
  end

  it "should show the user's profile picture" do
   expect(page).to have_css("img[src='#{@fake_user.photo}']")
  end

  it "should show the user's username" do
    expect(page).to have_content(@fake_user.name)
  end

  it 'should show the number of posts the user owns' do
    expect(page).to have_content("#{@fake_user.posts_counter} posts")
  end

  it "should show the user posts' titles" do
    @posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it "should show the first 100 characters of the user posts' bodies" do
    @posts.each do |post|
      expect(page).to have_content(post.text[0..100])
    end
  end

  it 'should show the 3 most recent comments on a post' do
    NUM_COMMENTS_ALLOWED = 3
    NUM_COMMENTS_CREATED = 5
    NUM_COMMENTS_HIDDEN = NUM_COMMENTS_CREATED - NUM_COMMENTS_ALLOWED
    comments = []

    NUM_COMMENTS_CREATED.times do |i|
      comment = Comment.create(
        author: @fake_user,
        post: @posts[0],
        text: "This is the comment example number #{i}"
      )
      comments.push(comment)
    end

    visit user_posts_path(@fake_user)

    comments[0...NUM_COMMENTS_HIDDEN].each do |comment|
      expect(page).not_to have_content(comment.text)
    end

    comments[NUM_COMMENTS_HIDDEN..-1].each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'should show how many comments a post has' do
    num_comments_created = 5

    num_comments_created.times do |i| 
      post_index = i % (@posts.length - 1)

      Comment.create(
        author: @fake_user,
        post: @posts[post_index],
        text: "This is the comment example number #{i}"
      ) 
    end

    visit user_posts_path(@fake_user)

    @posts.each do |post|
      expect(page).to have_content("#{post.comments_counter} comments")
    end
  end

  it 'should show how many likes a post has' do
    @posts.each do |post|
      expect(page).to have_content("#{post.likes_counter} comments")
    end
  end

  it 'should redirects the user to the correct post\'s show page, when he clicks on a specific post' do
    @posts.each do |post|
      visit user_posts_path(@fake_user)
      
      click_link post.title
      
      expect(current_path).to eq user_post_path(@fake_user, post)
    end
  end
end