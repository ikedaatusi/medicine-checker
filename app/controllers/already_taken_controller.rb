class AlreadyTakenController < ApplicationController
  def index
    #服用期間が終了した薬を表示させる
    @day = Date.today
    special_drug_ids = current_user.drugs.where.not(start_time: nil).pluck(:id)
    @drugs = current_user.drugs.includes(:take_times).where(id: special_drug_ids).where('end_time < ?', Date.today)
  end

  def show
  end

  def new
  end

  def edit
  end
end
