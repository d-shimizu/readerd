class Feed < ActiveRecord::Base
  belongs_to :category
  has_many :entries
  attr_accessible :feed_url, :title, :url, :last_modified, :category_id
  
  #validates :url, :presence => true, :with => URI.regexp(['http', 'https'])
  validates :url, :presence => true
end
