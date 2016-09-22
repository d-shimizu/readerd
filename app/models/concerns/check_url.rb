require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
module CheckURL
  def check_url(url)
    begin
      doc = Nokogiri::HTML(open(url,:allow_redirections => :safe).read,nil,'utf-8')
      return true
    rescue => ex
      return false
    end
  end
end
