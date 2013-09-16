require 'feedzirra'
module AddFeed
  def add_feed(url)
    if url != ""
      begin
        doc = Nokogiri::HTML(open(url),nil,'utf-8')
        retrun true
      rescue => ex
        return false
        #if doc != nil
        #  return true
        #else
        #  return false
        #end
      end
    else
      return true
    end

  end
end
