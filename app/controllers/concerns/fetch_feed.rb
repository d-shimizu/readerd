module FetchFeed
  def feed_fetch

        if false && @feed.last_modified != nil
          parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed.feed_url}", :if_modified_since => feed.last_modified
        else
          parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed.feed_url}"
        end

        if !parsedFeed || parsedFeed.instance_of?(Fixnum)
          p 'Skipped ' + @feed.url
        end

        #tmp = parsedFeed.entries
        p parsedFeed.entries
        #p tmp
        @parsedFeed_entries_tmp = parsedFeed.entries
        if parsedFeed.entries.length > 2
        #if tmp.length > 2
          begin
            @parsedFeed_entries_tmp = parsedFeed.entries.sort{|aa, bb|
              #if aa.published != bb.published
                aa.published <=> bb.published
              #end
            }
          rescue ArgumentError
            @parsedFeed_entries_tmp = parsedFeed.entries
          end
        end
        parsedFeed_entries = @parsedFeed_entries_tmp.reverse

        ### Get latest entry
        latest_entry = Entry.where(:feed_id => @feed.id).order('created_at DESC').first

        ### Take updated entries
        if latest_entry != nil
          updatedEntries = parsedFeed_entries.take_while {
            |e| e.published != latest_entry.published_at
          }
        else
          updatedEntries = parsedFeed_entries
        end

        ### Save entries
        updatedEntries.reverse.each do |feed_entry|

          if feed_entry.url.nil? == false && feed_entry.url.include?("#comment-") == false
             p 'Add => ' + feed_entry.url
             p feed_entry.published

             entry = Entry.new({
               :feed_title   => @feed.title,
               :title        => feed_entry.title,
               :url          => feed_entry.url,
               :summary      => (feed_entry.summary || feed_entry.content || '').gsub(/<.+?>/m, '').slice(0, 255),
               :published_at => feed_entry.published,
               :feed_id      => @feed.id
             })
             entry.save
          end
       end

  end
end
