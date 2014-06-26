# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

action = Category.create(name: "Action")
comedy = Category.create(name: "Comedy")
drama = Category.create(name: "Drama")
reality = Category.create(name: "Reality")
sports = Category.create(name: "Sports")
horror = Category.create(name: "Horror")


Video.create(
    title: 'Futurama',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: comedy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/futurama_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/futurama_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Futurama+-+S07E23+-+Game+of+Tones+Ending+-+Fry%27s+Mom%27s+Dream.mp4'
)

Video.create(
    title: 'Simpson',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: comedy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/simpsons_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/simpsons_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Maggie+Simpson+in+The+Longest+Daycare+_+The+Simpsons+_+ANIMATION+on+FOX.mp4'
)

Video.create(
    title: 'Monk',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/monk_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/monk_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Mr.+Monk+is+touching+the+lamp.mp4'
)

Video.create(
    title: 'Fight Club',
    description: 'Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.',
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fight_club_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fight_club_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Fight+Club+The+8+Rules.mp4'
)

User.create(full_name: 'Administrator', email: 'admin@gmail.com', password: 'admin', admin: true, customer_token: "cus_4HUdA4foOplPUe")
