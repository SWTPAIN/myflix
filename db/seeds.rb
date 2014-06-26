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
scifi = Category.create(name: "Sic-Fi")
fantasy = Category.create(name: "Fantasy")
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
    description: 'The satiric adventures of a working-class family in the misfit city of Springfield.',
    category: comedy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/simpsons_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/simpsons_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Maggie+Simpson+in+The+Longest+Daycare+_+The+Simpsons+_+ANIMATION+on+FOX.mp4'
)
Video.create(
    title: 'Up',
    description: "By tying thousands of balloons to his home, 78-year-old Carl sets out to fulfill his lifelong dream to see the wilds of South America. Russell, a wilderness explorer 70 years younger, inadvertently becomes a stowaway.",
    category: comedy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/up_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/up_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/UP!+Carl+_+Ellie.mp4'
)

Video.create(
    title: 'Monk',
    description: 'Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.',
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/monk_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/monk_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Mr.+Monk+is+touching+the+lamp.mp4'
)
Video.create(
    title: 'Fight Club',
    description: 'An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more...',
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fight_club_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fight_club_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Fight+Club+The+8+Rules.mp4'
)
Video.create(
    title: 'American Beauty',
    description: "Lester Burnham, a depressed suburban father in a mid-life crisis, decides to turn his hectic life around after becoming infatuated with his daughter's attractive friend.",
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/american_beauty_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/american_beauty_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/American+Beauty+Ending+(1999).mp4'
)

Video.create(
    title: '12 Angry Men',
    description: "A dissenting juror in a murder trial slowly manages to convince the others that the case is not as obviously clear as it seemed in court.",
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/twelve_angry_men_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/twelve_angry_men_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/12+Angry+Men+-+This+is+how+you+deal+with+prejudice.mp4'
)
Video.create(
    title: 'Breaking Bad',
    description: "To provide for his family's future after he is diagnosed with lung cancer, a chemistry genius turned high school teacher teams up with an ex-student to cook and sell the world's purest crystal meth.",
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/breaking_bad_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/breaking_bad_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Breaking+Bad+-+This+is+not+meth...+Most+badassed+scene+EVER!!!!.mp4'
)
Video.create(
    title: 'The Pursuit of Happyness',
    description: "A struggling salesman takes custody of his son as he's poised to begin a life-changing professional endeavor.",
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_pursuit_of_happyness_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_pursuit_of_happyness_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Pursuit+Of+Happyness+-+Basketball+Scene+%5BHD%5D.mp4'
)
Video.create(
    title: 'The Shawshank Redemption',
    description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
    category: drama,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_shawshank_redemption_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_shawshank_redemption_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/The+Shawshank+Redemption+-+Escape+Andy+Dufrense.mp44'
)
Video.create(
    title: 'Man on Fire',
    description: "In Mexico City, a former assassin swears vengeance on those who committed an unspeakable act against the family he was hired to protect.",
    category: action,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/man_on_fire_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/man_on_fire_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Man+On+Fire+(2004)+Theatrical+Trailer.mp4'
)
Video.create(
    title: '300',
    description: "King Leonidas and a force of 300 men fight the Persians at Thermopylae in 480 B.C.",
    category: action,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/300_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/300_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/300+-+First+Battle+Scene+-+Full+HD+1080p+-+Earthquake.+No+Captain%2C+Battle+Formations.mp4'
)
Video.create(
    title: 'Fast & Furious 6',
    description: "Hobbs has Dom and Brian reassemble their crew in order to take down a mastermind who commands an organization of mercenary drivers across 12 countries. Payment? Full pardons for them all.",
    category: action,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fast_and_furious_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fast_and_furious_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Fast+_+Furious+6+-+Fight+on+the+plane.mp4'
)
Video.create(
    title: 'Fury',
    description: "April, 1945. As the Allies make their final push in the European Theatre, a battle-hardened army sergeant named Wardaddy commands a Sherman tank and her five-man crew on a deadly mission behind enemy lines. Outnumbered and out-gunned, and with a rookie soldier thrust into their platoon, Wardaddy and his men face overwhelming odds in their heroic attempts to strike at the heart of Nazi Germany.",
    category: action,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fury_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/fury_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Fury+-+Trailer+1.mp4'
)
Video.create(
    title: 'Dawn of the Planet of the Apes',
    description: "A growing nation of genetically evolved apes led by Caesar is threatened by a band of human survivors of the devastating virus unleashed a decade earlier. They reach a fragile peace, but it proves short-lived, as both sides are brought to the brink of a war that will determine who will emerge as Earth's dominant species. ",
    category: scifi,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/dawn_planet_of_the_ape_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/dawn_planet_of_the_ape_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Dawn+of+the+Planet+of+the+Apes+Trailer+2014+Movie+-+Official+%5BHD%5D.mp4'
)
Video.create(
    title: 'Edge of Tomorrow',
    description: "An officer finds himself caught in a time loop in a war with an alien race. His skills increase as he faces the same brutal combat scenarios, and his union with a Special Forces warrior gets him closer and closer to defeating the enemy.",
    category: scifi,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/edge_of_tomorrow_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/edge_of_tomorrow_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Edge+of+Tomorrow+-+Official+Main+Trailer+%5BHD%5D.mp4'
)
Video.create(
    title: 'Captain America: The Winter Soldier',
    description: "Steve Rogers struggles to embrace his role in the modern world and battles a new threat from old history: the Soviet agent known as the Winter Soldier.",
    category: scifi,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/captian_americna_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/captian_americna_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Captain+America+The+Winter+Soldier+trailer+UK+--+Official+Marvel+_+HD.mp4'
)
Video.create(
    title: 'The Wolverine',
    description: "When Wolverine is summoned to Japan by an old acquaintance, he is embroiled in a conflict that forces him to confront his own demons.",
    category: scifi,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_wolverine_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_wolverine_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/The+Wolverine+-+Official+Trailer+2+%5BHD%5D(NetMob.in).mp4'
)

Video.create(
    title: 'Pirates of the Caribbean: On Stranger Tides',
    description: "Jack Sparrow and Barbossa embark on a quest to find the elusive fountain of youth, only to discover that Blackbeard and his daughter are after it too.",
    category: fantasy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/pirate_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/pirate_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Dead+Mans+Chest+big+octopus+scene.mp4'
)
Video.create(
    title: 'Inception',
    description: "A skilled extractor is offered a chance to regain his old life as payment for a task considered to be impossible.",
    category: fantasy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/inception_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/inception_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Inception+-+Ariadne+Learns+How+To+Build+Dreams.mp4'
)
Video.create(
    title: 'The Dark Knight',
    description: "When Batman, Gordon and Harvey Dent launch an assault on the mob, they let the clown out of the box, the Joker, bent on turning Gotham on itself and bringing any heroes down to his level.",
    category: fantasy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_dark_night_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_dark_night_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Heath+Ledger+-+Incredible+Acting.mp4'
)


Video.create(
    title: 'Life of Pi',
    description: "A young man who survives a disaster at sea is hurtled into an epic journey of adventure and discovery. While cast away, he forms an unexpected connection with another survivor: a fearsome Bengal tiger.",
    category: fantasy,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/life_of_pi_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/life_of_pi_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/Pi+and+Richard+Parker.mp4'
)

Video.create(
    title: '28 Days Later',
    description: "Four weeks after a mysterious, incurable virus spreads throughout the UK, a handful of survivors try to find sanctuary.",
    category: horror,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/28_days_later_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/28_days_later_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/28+Days+Later+(2002)+Official+Trailer.mp4'
)
Video.create(
    title: 'The Walking Dead',
    description: "Police officer Rick Grimes leads a group of survivors in a world overrun by zombies.",
    category: horror,
    remote_small_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_walking_daed_small.jpg',
    remote_large_cover_url: 'https://s3.amazonaws.com/zenlifting/myflix/the_walking_daed_large.jpg',
    video_url: 'https://s3.amazonaws.com/zenlifting/myflix/The+Walking+Dead+Season+1+Trailer+english+HD.mp4'
)



User.create(full_name: 'Administrator', email: 'admin@gmail.com', password: 'admin', admin: true, customer_token: "cus_4HUdA4foOplPUe")
