# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

# Create 5 random users
5.times do
  User.create(
    name: Faker::Name.name,
    photo: Faker::Avatar.image,
    bio: Faker::Lorem.sentence
  )
end

# Create 15 random posts with 10 random comments and 5 random likes for each post
15.times do
  post = Post.create(
    author: User.all.sample,
    title: Faker::Lorem.sentence,
    text: Faker::Lorem.paragraph
  )

  10.times do
    Comment.create(
      user: User.all.sample,
      post: post,
      text: Faker::Lorem.sentence
    )
  end

  5.times do
    Like.create(
      user: User.all.sample,
      post: post
    )
  end
end
