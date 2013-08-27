class HomeController < ApplicationController
  def index
    @categories = Category.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
    @tags       = Tag.all.inject([]) {|r,i| r.push(i.name) }.unshift(nil)
  end
end
