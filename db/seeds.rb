# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

action = Category.create(name: "Action")
comedy = Category.create(name: "Comedy")
drama = Category.create(name: "Drma")
reality = Category.create(name: "Reality")
sports = Category.create(name: "Sports")
horror = Category.create(name: "Horror")


Video.create(
    title: 'Futurama',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: comedy,
    small_cover: File.open(Rails.root.join("public/tmp/futurama_small.jpg")),
    large_cover: File.open(Rails.root.join("public/tmp/futurama_large.jpg")),
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Futurama+-+S07E23+-+Game+of+Tones+Ending+-+Fry%27s+Mom%27s+Dream.mp4'
)


Video.create(
    title: 'Simpson',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: comedy,
    small_cover: File.open(Rails.root.join("public/tmp/simpsons_small.jpg")),
    large_cover: File.open(Rails.root.join("public/tmp/simpsons_large.jpg")),
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Maggie+Simpson+in+The+Longest+Daycare+_+The+Simpsons+_+ANIMATION+on+FOX.mp4'
)

Video.create(
    title: 'Monk',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: drama,
    small_cover: File.open(Rails.root.join("public/tmp/monk_small.jpg")),
    large_cover: File.open(Rails.root.join("public/tmp/monk_large.jpg")),
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Mr.+Monk+is+touching+the+lamp.mp4'
)

Video.create(
    title: 'Fight Club',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: drama,
    small_cover: File.open(Rails.root.join("public/tmp/fight_club_small.jpg")),
    large_cover: File.open(Rails.root.join("public/tmp/fight_club_large.jpg")),
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Fight+Club+The+8+Rules.mp4'
)

User.create(full_name: 'Administrator', email: 'admin@gmail.com', password: 'admin', admin: true, customer_token: "cus_4HUdA4foOplPUe")

Video.all.each do |video|
  5.times { video.reviews.create(user: User.first, rating: (0..5).to_a.sample, content: Faker::Lorem.paragraph) }
end