class RootController < ApplicationController
  def index

    #@feeds = Feed.all
    @entries = Entry.includes([:feed]).order('published_at DESC').page(params[:page]).per(25)

    respond_to do |format|
      format.html
      format.json { render :json => {
        :feed    => @feed,
        :entries => @entries
      }}
    end

  end

end
