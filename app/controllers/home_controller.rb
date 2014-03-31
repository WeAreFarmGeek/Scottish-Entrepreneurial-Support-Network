class HomeController < ApplicationController
   before_filter :get_data, only: [:index, :embed]
   after_action :allow_iframe, :only => :embed

   def index
   end

  def embed
    @embed = true
    render :index, :layout => 'embed'
  end

  private

  def get_data
    @categories   = Category.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
    @tags         = Tag.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
    @search_types = SearchType.all
  end

  def allow_iframe
    response.headers.delete('X-Frame-Options')
  end

end
