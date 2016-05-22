# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Activity.find_or_create_by(key: "unknown")
Activity.find_or_create_by(key: "run")
Activity.find_or_create_by(key: "cycle")
Activity.find_or_create_by(key: "hike")
Activity.find_or_create_by(key: "commute")
