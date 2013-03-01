class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :screen_name
  belongs_to :user

  validates_presence_of :user_id, :uid, :provider

  validates_uniqueness_of :uid, :scope => :provider
  
  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user = User.find_by_email('twitter_app@test.com')
    Authorization.create(:user_id => user.id, :uid => hash['uid'], :provider => hash['provider'], :screen_name => hash["info"]["nickname"])
  end
end

