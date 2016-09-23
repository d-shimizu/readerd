class RootController < ApplicationController
  def index
    @feeds = Feed.all.order('title ASC')
    #@feed = Feed.all.order('title ASC')
    #@entries = Entry.includes([:feed]).order('published_at DESC').page(params[:page]).per(16)
    @entries = Entry.includes(:feed).order('published_at DESC').page(params[:page]).per(16)
    #@entries = Entry.references([:feed]).order('published_at DESC').page(params[:page]).per(16)
    #@feedtitle = Entry.includes(:feed).references([:feed])
    #@entries = Entry.joins([:feed]).order('published_at DESC').page(params[:page]).per(16)
    #@entries = Entry.joins([:feed]).order('published_at DESC').page(params[:page]).per(16)
    #@entries = Entry.includes(:feed).references(:feed).order('published_at DESC').page(params[:page]).per(16)
    #@entries = Entry.includes(:feed).references(:feed).order('published_at DESC').page(params[:page]).per(16)
    #$@entries = Entry.joins(:feed).includes(:feed).order('published_at DESC').page(params[:page]).per(16)
    #@feedtitle=Feed.all(:joins => :title)

    #%x( bundle exec rake "fetch_feed:fetch" )
    #Rails.logger.info `bundle exec rake "fetch_feed:fetch"`

    respond_to do |format|
      format.html
      format.json { render :json => {
        #:feeds   => @feeds,
        #:feed   => @feed,
       :entries => @entries
      }}
    end

  end

  def feed_update
    %x( bundle exec rake "fetch_feed:fetch" )
    Rails.logger.info `bundle exec rake "fetch_feed:fetch"`
    respond_to do |format|
      format.html
      format.json { render :json => {
        #:feeds   => @feeds,
        #:feed   => @feed,
       :entries => @entries
      }}
    end
  end

end
