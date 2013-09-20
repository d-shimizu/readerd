class Feed < ActiveRecord::Base
  require 'check_url'
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
      errors.add(:url, "Invalid")
    end
    get_url=Feed.where(:url => "#{url}").first
    get_feedurl=Feed.where(:feed_url => "#{feed_url}").first
    ### IDを検索して、URLとIDが共にあればTrueを返す
    #get_url=Feed.where(:url => "#{url}").first
    #get_url=Feed.find_by_url("#{url}")
    if get_url != url && get_feedurl == feed_url
      errors.add(:url, "already exist")
    end
  end

  #validate :sameurlcheck
  #def sameurlcheck
  #  get_url=Feed.where(:url => "#{url}").first
  #  if get_url != nil
  #    errors.add(:url, "already exist")
  #  end
  #end

end
