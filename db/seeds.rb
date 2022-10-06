# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

MAX_POSTS_BY_USER = 10
MAX_COMMENTS_BY_POST = 10

admin = User.create(
  name: 'Gabriel Santo',
  bio: 'Im Gabriel, the admin, and this is my bio...',
  email: 'admin@test.com',
  password: 'password',
  password_confirmation: 'password'
)

john = User.create(
  name: 'John Doe',
  bio: 'Im John Doe and this is my bio...',
  email: 'john@test.com',
  password: 'password',
  password_confirmation: 'password'
)

jane = User.create(
  name: 'Jane Doe',
  bio: 'Im Jane Doe and this is my bio...',
  email: 'jane@test.com',
  password: 'password',
  password_confirmation: 'password'
)

users = [admin, john, jane]

users.each do |user|
  num_posts_to_create = rand(1..MAX_POSTS_BY_USER)

  num_posts_to_create.times do |i|
    post = Post.create(
      title: "Title #{i + 1}",
      text: "This is the body of the post #{i + 1}",
      author: user
    )
  
    num_comments_to_create = rand(0..MAX_COMMENTS_BY_POST)
    num_comments_to_create.times do |j|
      user_index = j % users.length

      post.comments.create(
        text: "Comment #{j + 1}",
        author: users[user_index]
      )
    end
  end
end




