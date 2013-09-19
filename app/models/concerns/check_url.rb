require 'nokogiri'
require 'open-uri'
module CheckURL
  def check_url(url)
      begin
        doc = Nokogiri::HTML(open(url).read,nil,'utf-8')
        return true
      rescue => ex
        return false
      end
  end
end
