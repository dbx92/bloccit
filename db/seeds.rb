# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "random_data"


5.times do
  User.create!(
    name: RandomData.random_name,
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

5.times do
  Topic.create!(
    name: RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

5.times do
  Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

10.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: rand(1..99)
  )
end

5.times do
  Question.create!(
    title:RandomData.random_sentence,
    body:RandomData.random_paragraph,
    resolved:false
  )
end

10.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_sentence,
    price: rand(1..99)
  )
end

posts = Post.all

10.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

unique = Post.create_with(topic: topics.sample).find_or_create_by!(title: "Unique", body:"Unique Body 12345678910", user: users.sample)
Comment.find_or_create_by!(post:unique,body: "Unique", user: unique.user)

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

moderator = User.create!(
  name: 'Moderator',
  email: 'moderator@example.com',
  password: 'helloworld',
  role: 'moderator'
)



puts "Seed finished"
puts "#{User.count} users created"
puts "#{SponsoredPost.count} sponsored posts"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
puts "#{Topic.count} topics created"
puts "#{admin.name} created"
puts "#{member.name} created"
puts "#{moderator.name} created"
