class FeedsController < ApplicationController
  require 'fetch_feed'
  require 'url_analyze'
  include FetchFeed
  include UrlAnalyze
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all

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
    #@entries = @feed.entries.includes([:feed]).page params[:page]
    @entries = @feed.entries.includes([:feed]).page(params[:page]).order('published_at DESC').per(16)
    #@entries = Entry.includes([:feed]).order('published_at DESC').page(params[:page]).per(10)
    @category = @feed.category

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=>{
        :feed     => @feed,
        :category => @category,
        :entries  => @entries
      }}
    end
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    #@feed.url = URI.parse(@feed.url).scheme + "://" + URI.parse(@feed.url).host + "/" rescue @feed = Feed.new(feed_params)
    @feed.title, @feed.url, @feed.feed_url, @feed.last_modified = url_analyze(@feed.url)

    respond_to do |format|
      if @feed.save
        feed_fetch 

        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render action: 'show', status: :created, location: @feed }
      else
        format.html { render action: 'new' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
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
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:title, :url, :feed_url, :category_id, :last_modified)
    end
end
