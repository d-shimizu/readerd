class Feed < ActiveRecord::Base
  include CheckURL
  belongs_to :category
  has_many :entries
  attr_accessible :feed_url, :title, :url, :last_modified, :category_id
  
  #validates :url, :presence => true, :with => URI.regexp(['http', 'https'])
  validates :url, :presence => true

  validate :url_check
  def url_check
    res = check_url(self.url)
    if res == false && self.url != ""
      errors.add(:url, "が誤ってます。")
    end
  end

end
