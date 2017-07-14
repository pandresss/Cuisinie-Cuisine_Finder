# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cuisine.delete_all
Cuisine.create([
                 { name: 'BBQ', value: '193' },
                 { name: 'Bar Food ', value: '227' },
                 { name: 'Caribbean', value: '168' },
                 { name: 'Chinese', value: '25' },
                 { name: 'Indian', value: '148' },
                 { name: 'Italian', value: '55' },
                 { name: 'Japanese', value: '60' },
                 { name: 'TexMex', value: '150' },
                 { name: 'Sushi', value: '177' },
                 { name: 'Vegetarian', value: '308' }
               ])
puts "#{Cuisine.count} has been created"
