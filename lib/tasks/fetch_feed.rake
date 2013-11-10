require 'feedzirra'
require 'open-uri'
require 'nokogiri'
require 'rss'

namespace :fetch_feed do
  desc "fetch RSS feed"

    task :fetch => :environment do
      p Time.now
      p "Start Fetch:Feed Rake Task"
      print("\n")

      Feed.all.each do |feed|

        if feed.url != nil && (feed.feed_url == "" || feed.feed_url == nil)
          feed_url = nil
          site_url = feed.url
          p site_url
          begin
            doc = Nokogiri::HTML(open(site_url),nil,'utf-8')
          rescue Exception => e
            p "URL Analyze(Nokogiri) Error" + feed.url
            next
          end

          doc.css('link').each do |link|

            if link['type'] == 'application/rss+xml' && link['rel'] == 'alternate' && link['href'].include?("/comment/") == false && link['href'].include?("/comments/") == false
              href = link['href']
              feed_url = URI.join(site_url, href)
              p "feed_url #{feed_url}"
              break

            elsif link['type'] == 'application/atom+xml' && link['rel'] == 'alternate' && link['href'].include?("/comment/") == false && link['href'].include?("/comments/") == false
              href = link['href']
              feed_url = URI.join(site_url, href)
              p "atom_url #{feed_url}"
              break

            end
          end

        elsif feed.feed_url != nil
          feed_url = feed.feed_url
          p "rss_url #{feed_url}"

        end

          if false && feed.last_modified != nil
            parsedFeed = Feedzirra::Feed.fetch_and_parse "#{feed_url}", :if_modified_since => feed.last_modified
          else
            parsedFeed = Feedzirra::Feed.fetch_and_parse "#{feed_url}"
          end

          if !parsedFeed || parsedFeed.instance_of?(Fixnum)
            p 'Skipped '+feed.url
            next
          end

          # Update feed meta data
          if "#{feed_url}" != nil  then
            feed.title = parsedFeed.title
            feed.last_modified = parsedFeed.last_modified
            feed.feed_url = "#{feed_url}"
            if feed.url == nil
              feed.url = parsedFeed.url
            end
          end
          feed.save

          # DBに保存されている最新のエントリを取得
          latest_entry = Entry.where(:feed_id => feed.id).order('created_at DESC').first
          #p "latest_entry #{latest_entry}"
          # 取得したFeedを更新日時の昇順に並べ替え
          tmp = parsedFeed.entries
          parsedFeed_entries_tmp = tmp.sort{|aa, bb|
              aa.published <=> bb.published
          }
          # 降順に並べ替え
          parsedFeed_entries = parsedFeed_entries_tmp.reverse

          # latest_entryの更新日時とparsedFeed_entriesの更新日時を比較して
          # parsedFeed_entriesの更新日時が大きければupdatedEntriesへ格納
          if latest_entry != nil
            updatedEntries = parsedFeed_entries.take_while {
              |e| e.published > latest_entry.published_at
            }
          else
            updatedEntries = parsedFeed_entries
          end

          # Save entries
          updatedEntries.reverse.each do |feed_entry|

            if feed_entry.url.include?("#comment-") == false
              p 'Add => ' + feed_entry.url

              entry = Entry.new({
                :title        => feed_entry.title,
                :url          => feed_entry.url,
                :summary      => (feed_entry.summary || feed_entry.content || '').gsub(/<.+?>/m, '').slice(0, 255),
                :published_at => feed_entry.published,
                :feed_id      => feed.id
              })
              entry.save
            end
          end

      end
      print("\n")
      p "Finished Rake Task"

    end

end
