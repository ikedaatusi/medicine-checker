class CalendarsController < ApplicationController
    before_action :require_login
    def new
        date_param = params[:date]
    
        if date_param.present?
          begin
            @date = Date.parse(date_param)
          rescue ArgumentError
            # Handle the invalid date case
            @date = Date.today
            flash[:alert] = "Invalid date provided, using today's date instead."
          end
        else
          # Handle the case where no date is provided
          @date = Date.today
        end
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
  @drug = current_user.drugs.find(params[:id])
  redirect_to with_date_show_calendar_path(@drug, date: params[:date]), notice: notice_message
end
  end

      def update
        @drug = current_user.drugs.find(params[:id])
        if @drug.update(drug_params)
          redirect_to with_date_show_calendar_path(@drug, date: params[:date]), notice: '薬を編集しました', status: :see_other
        else
          @date = params[:date] ? Date.parse(params[:date]) : Date.today
          @medication_checks = MedicationCheck.where(drug: @drug, check_time: @date)
          render :edit, status: :unprocessable_entity
        end
      end

    def index
        @q = current_user.drugs.ransack(params[:q])
        @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page])
    end

    def show
        @drug = Drug.find(params[:id])
        @date = params[:date] ? Date.parse(params[:date]) : Date.today
        @medication_checks = MedicationCheck.where(drug: @drug, check_time: @date)
        @memo= Memo.where(drug: @drug, create_time: @date)
    end

    def edit
      @drug = current_user.drugs.find(params[:id])
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      @medication_checks = MedicationCheck.where(drug: @drug, check_time: @date)
    end

    private

    def medication_check_params
      params.require(:medication_check).permit(medication_checks_attributes: [:id, :check, :check_time, :take_time_id, :drug_id])
    end
    
    def drug_params
      params.require(:drug).permit(:hospital_name, :drug_name, :number_of_tablets, :image_url, :start_time, :end_time, take_times_attributes: [:id, :take_time, :_destroy], medication_checks_attributes: [:id, :check, :check_time, :take_time_id, :drug_id, :_destroy])
    end
end