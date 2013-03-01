# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.find_by_email("twitter_api@test.com")
if admin.blank?
  user = User.new(:first_name => "Twitter", :last_name => "API", :email => "twitter_api@test.com", :password => "oms@123", :password_confirmation => "oms@123")
  user.skip_confirmation!
  user.save
end