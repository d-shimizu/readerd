class FeedsController < ApplicationController
  require 'fetch_feed'
  require 'url_analyze'
  require 'feed_analyze'
  require 'check_url'
  include CheckURL
  include FetchFeed
  include UrlAnalyze
  include FeedAnalyze
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  #before_action :set_feed, only: [:edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    #@feeds = Feed.all
    @feeds = Feed.all.order('title ASC')

    respond_to do |format|
      format.html
      format.json { render :json => {
        :feeds => @feeds
      }}
    end

  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])
    #feed_id =  @feed.id
    #@feed = Feed.new(feed_id)
    #@feed.entries.where(feed_id: "#{feed_id}").destroy_all
    @feeds = Feed.all.order('title ASC')
    #@entries = @feed.entries.includes([:feed]).page(params[:page]).order('published_at DESC').per(16)
    #@entries = @feed.entries.includes([:feed]).references(:feed).page(params[:page]).order('published_at DESC').per(16)
    #@category = @feed.category

    #@feed = Feed.new(feed_params)
    #@feed = Feed.new
    #@feed = Feed.all
    #@feeds = Feed.all.order('title ASC')
    @entries = @feed.entries.includes([:feed]).page(params[:page]).order('published_at DESC').per(16)

    #@entries = @feed.entries.includes([:feed]).references(:feed).page(params[:page]).order('published_at DESC').per(16)
    #@category = @feed.category

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=>{
        :feed    => @feed,
        :feeds    => @feeds,
        :category => @category,
        :entries  => @entries
      }}
    end
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
    @feeds = Feed.all.order('title ASC')
    respond_to do |format|
      format.html
      format.json { render :json => {
        :feed  => @feed,
        :feeds => @feeds
      }}
    end
  end

  # GET /feeds/1/edit
  def edit
    #@feed = Feed.new(feed_params)
    #@feed = Feed.new
    @feeds = Feed.all.order('title ASC')
    respond_to do |format|
      format.html
      format.json { render :json => {
        :feeds => @feeds
      }}
    end
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    @feeds = Feed.all.order('title ASC')
    @feedtmp = url_analyze(@feed.url)

    unless params[:feedurl].blank?
      @feed.feed_url=params["feedurl"]["0"]

      @feed.title, @feed.url, @feed.feed_url, @feed.last_modified = feed_analyze(@feed.feed_url)
      respond_to do |format|
        if @feed.save
          feed_fetch
          format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
	      format.json { render action: 'show', status: :created, location: @feed, :json => { :feed  => @feed, :feeds => @feeds } }
        else
          format.html { render action: 'new' }
	      format.json { render json: @feed.errors, status: :unprocessable_entity, :json => { :feed  => @feed, :feeds => @feeds } }
        end
      end
    else
#        respond_to do |format|
#          format.html { render action: 'confirm' }
#          format.json { render json: @feed.errors, status: :unprocessable_entity, :json => { :feed  => @feed, :feeds => @feeds } }
#        end

      respond_to do |format|
        #if params["feed"]["url"].blank?
        # 空白でないとき
        #unless params["feed"]["url"].blank?
        res = check_url(@feed.url)
        #unless params["feed"]["url"].blank? && @feed.url == params["feed"]["url"]
        unless params["feed"]["url"].blank?
          #@feed.feed_url=params["feedurl"]["0"]
          #unless (Nokogiri::HTML(open(@feed.url),nil,'utf-8')) == false 
          if res == false
            format.html { render action: 'new' }
	        format.json { render json: @feed.errors, status: :unprocessable_entity, :json => { :feed  => @feed, :feeds => @feeds } }
          else
            format.html { render action: 'confirm' }
            format.json { render json: @feed.errors, status: :unprocessable_entity, :json => { :feed  => @feed, :feeds => @feeds } }
          end
        else
          format.html { render action: 'new' }
	      format.json { render json: @feed.errors, status: :unprocessable_entity, :json => { :feed  => @feed, :feeds => @feeds } }
        end
      end
    end

  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    @feeds = Feed.all.order('title ASC')
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.', :json => { :feeds => @feeds }}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feed.errors, status: :unprocessable_entity , :json => { :feeds => @feeds }}
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy

    feed_id =  @feed.id
    @feed.entries.where(feed_id: "#{feed_id}").destroy_all

    respond_to do |format|
      format.html { redirect_to "/",  notice: 'Feed was successfully deleted' }
      format.json { head :no_content }
    end
  end

  def confirm
    @feed=params[:feedurl]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:title, :url, :feed_url, :category_id, :last_modified) if params[:feed]
      #params.require(:feed).permit(:title, :url, :feed_url, :category_id, :last_modified)
    end
end
