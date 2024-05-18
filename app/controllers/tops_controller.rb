class TopsController < ApplicationController
  def index
    @day = Date.today
    special_post_ids = Drug.where.not(start_time: nil).pluck(:id)
    @special_posts = Drug.includes(:take_times).where(id: special_post_ids).where('start_time <= ?', Date.today).where('end_time >= ?', Date.today)
    @q = Drug.ransack(params[:q])
    @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page])
  end
end
