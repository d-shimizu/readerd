require 'feedzirra'
module AddFeed
  def add_feed(url)
    doc = Nokogiri::HTML(open(url),nil,'utf-8')

      if doc != nil
        return true
      else
        return false
      end

  end
end
