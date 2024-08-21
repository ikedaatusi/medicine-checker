class DrugConfirmationsController < ApplicationController
  before_action :require_login

  def index
    @q = current_user.drugs.joins(:medication_checks).where(medication_checks: { check: true }).ransack(params[:q])
    @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page])
  end
  
  def show
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @drug = Drug.find(params[:id])
    @medication_checks = MedicationCheck.where(drug: @drug, check_time: @date)
  end
  
  def new
  end

  def update
    Rails.logger.debug("Medication Check Params: #{params[:medication_check]}")
        notice_message = nil
        alert_message = nil
        
        params[:medication_checks_attributes].each do |key, mc_params|
      @drug = Drug.find(mc_params[:drug_id])
      
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

  def edit
    @drug = current_user.Drug.find(params[:drug_id])
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @medication_checks = MedicationCheck.where(drug: @drug, check_time: @date)
  end

  private

    def calendar_check_params
          params.require(:medication_check).permit(medication_checks_attributes: [:id, :check, :check_time, :take_time_id, :drug_id])
    end
  end
end