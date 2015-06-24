# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

comedy = Category.create({name: 'Comedy'})
drama = Category.create({name: 'Drama'})
crime = Category.create({name: 'Crime'})
sci_fi = Category.create({name: 'Science-Fiction'})
family = Category.create({name: 'Family'})


south_park = Video.create({title: 'South Park',description: 'A rude comedy series', 
  small_cover_url: '/tmp/south_park.jpg', categories: [comedy]})
family_guy = Video.create({title: 'Family Guy',description: 'A family oriented comedy series', 
  small_cover_url: '/tmp/family_guy.jpg', categories: [family, comedy]})
futurama = Video.create({title: 'Futurama',description: 'A science-fiction comedy series', 
  small_cover_url: '/tmp/futurama.jpg', categories: [family, comedy, sci_fi]})
monk = Video.create({title: 'Monk',description: 'A detective series about a neurotic detective', 
  small_cover_url: '/tmp/monk.jpg', large_cover_url: 'tmp/monk_large.jpg', categories: [drama, crime]})
south_park = Video.create({title: 'South Park',description: 'A rude comedy series', 
  small_cover_url: '/tmp/south_park.jpg', categories: [comedy]})
family_guy = Video.create({title: 'Family Guy',description: 'A family oriented comedy series', 
  small_cover_url: '/tmp/family_guy.jpg', categories: [family, comedy]})
futurama = Video.create({title: 'Futurama',description: 'A science-fiction comedy series', 
  small_cover_url: '/tmp/futurama.jpg', categories: [family, comedy, sci_fi]})
monk = Video.create({title: 'Monk',description: 'A detective series about a neurotic detective', 
  small_cover_url: '/tmp/monk.jpg', large_cover_url: 'tmp/monk_large.jpg', categories: [drama, crime]})
family_guy = Video.create({title: 'Family Guy',description: 'A family oriented comedy series', 
  small_cover_url: '/tmp/family_guy.jpg', categories: [family, comedy]})
futurama = Video.create({title: 'Futurama',description: 'A science-fiction comedy series', 
  small_cover_url: '/tmp/futurama.jpg', categories: [family, comedy, sci_fi]})
monk = Video.create({title: 'Monk',description: 'A detective series about a neurotic detective', 
  small_cover_url: '/tmp/monk.jpg', large_cover_url: 'tmp/monk_large.jpg', categories: [drama, crime]})
