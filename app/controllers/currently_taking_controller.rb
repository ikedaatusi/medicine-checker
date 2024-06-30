class CurrentlyTakingController < ApplicationController
  before_action :require_login

  def index #服用期間中の薬だけ表示させる
    @day = Date.today
    special_drug_ids = current_user.drugs.where.not(start_time: nil).pluck(:id)
    @search_results = current_user.drugs.includes(:take_times).where(id: special_drug_ids).where('start_time <= ?', Date.today).where('end_time >= ?', Date.today)
    @q = @search_results.ransack(params[:q])
    @drugs =  @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page]).per(12)
    
  end
end
