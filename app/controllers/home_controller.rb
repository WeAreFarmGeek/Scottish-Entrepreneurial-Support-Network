class HomeController < ApplicationController
  def index
    @categories = Category.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
    @tags       = Tag.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
    @search_types = SearchType.all
  end

  def embed
    @embed      = true
    @categories = Category.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
    @tags       = Tag.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
    @search_types = SearchType.all
    render :index, :layout => 'embed'
  end

end
