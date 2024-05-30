class MedicationChecksController < ApplicationController
  before_action :require_login
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
  redirect_to medication_checks_path, notice: notice_message
end
  end


    def show
      @day = Date.today
      @drug = current_user.find(params[:id])
    end

    def index
      # @drug = Drug.find(params[:id])
      @day = Date.today
      special_drug_ids = current_user.drugs.where.not(start_time: nil).pluck(:id)
      @drugs = current_user.drugs.includes(:take_times).where(id: special_drug_ids).where('start_time <= ?', Date.today).where('end_time >= ?', Date.today)
    end
  

  private

  def medication_check_params
  #   params.permit(medication_checks_attributes: [:check, :check_time, :take_time_id, :drug_id])
  # end
    params.require(:medication_check).permit(medication_checks_attributes: [:id, :check, :check_time, :take_time_id, :drug_id])
  end
end
