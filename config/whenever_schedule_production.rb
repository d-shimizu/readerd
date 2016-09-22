# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# ログファイル出力先の指定
set :output, 'log/whenever.log'
# ジョブの実行環境の指定
set :environment, :production

every '0 0,9,12,22 * * *' do
  rake "fetch_feed:fetch"
end

