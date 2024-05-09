class TopsController < ApplicationController
  def index
    @day = Date.today
  end
end
