class RootController < ApplicationController
  def index
    @feeds = Feed.all.order('title ASC')
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

    respond_to do |format|
      format.html
      format.json { render :json => {
        :feeds   => @feeds,
        :entries => @entries
      }}
    end

  end

end
