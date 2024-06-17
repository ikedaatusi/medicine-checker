class CurrentlyTakingController < ApplicationController
  before_action :require_login
  
  def index #服用期間中の薬だけ表示させる
    @day = Date.today
    special_drug_ids = current_user.drugs.where.not(start_time: nil).pluck(:id)
    @search_results = current_user.drugs.includes(:take_times).where(id: special_drug_ids).where('start_time <= ?', Date.today).where('end_time >= ?', Date.today)
    @q = @search_results.ransack(params[:q])
    @drugs =  @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page]).per(12)
    
  end


  def new
    @day = Date.today
    @drug = Drug.find(params[:drug_id])
    @medication_check = MedicationCheck.new
  end

  def create
    Rails.logger.debug("Medication Check Params: #{params[:medication_check]}")
    notice_message = nil
    alert_message = nil

    params[:medication_checks_attributes].each do |key, mc_params|
  @drug = current_user.drugs.find(mc_params[:drug_id])
  
  @take_time = TakeTime.find(mc_params[:take_time_id])
  check_time = mc_params[:check_time]

  existing_check = MedicationCheck.find_by(drug: @drug, take_time: @take_time, check_time: check_time)
  if existing_check
    if existing_check.update(mc_params.permit(:check, :check_time, :take_time_id, :drug_id))
      notice_message = '保存しました'
    else
      alert_message = '保存に失敗しました。'
    end
  else
    @medication_check = MedicationCheck.new(mc_params.permit(:check, :check_time, :take_time_id, :drug_id))
    @medication_check.drug = @drug
    @medication_check.take_time = @take_time
    if @medication_check.save
      notice_message = '保存しました'
    else
      alert_message = '保存に失敗しました。'
    end
  end
end
if alert_message.present?
  render :new, alert: alert_message
else
  redirect_to calendars_path, notice: notice_message
end
  end

  def show
  end

  def edit
  end
end
