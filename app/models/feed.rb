class Feed < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  require 'check_url'
  include CheckURL
  belongs_to :category
  has_many :entries
  
  validates :url, :presence => true

  validate :url_check
  def url_check
    res = check_url(self.url)
    if res == false && self.url != ""
      errors.add(:url, "Invalid")
    end
    get_url=Feed.where(:url => "#{url}").first rescue get_url = nil
    url_id = get_url.id rescue url_id = nil
    url_entry = Entry.where(:feed_id => "#{url_id}").first rescue url_entry = nil
    if url_id != nil && url_entry != nil
      errors.add(:url, "already exist")
    end
  end

end
