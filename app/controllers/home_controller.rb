class HomeController < ApplicationController
  def index
    @activities = PublicActivity::Activity.all.order("created_at desc")
  end
end
