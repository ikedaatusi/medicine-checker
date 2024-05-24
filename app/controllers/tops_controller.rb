class TopsController < ApplicationController
  def index
    @day = Date.today
    special_post_ids = Drug.where.not(start_time: nil).pluck(:id)
    @drugs = Drug.includes(:take_times).where(id: special_post_ids).where('start_time <= ?', Date.today).where('end_time >= ?', Date.today)
    # @q = Drug.ransack(params[:q])
    # @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page])
  end

  def create
    @drug = Drug.find(params[:drug_id])
    @take_time = TakeTime.find(params[:take_time_id])
    check_time = params[:medication_check][:check_time].to_date

    # Find existing record with the same check_time
    existing_check = MedicationCheck.find_by(drug: @drug, take_time: @take_time, check_time: check_time)

    if existing_check
      # Update the existing record
      if existing_check.update(medication_check_params)
        redirect_to root_path, notice: 'Medication check was successfully updated.'
      else
        render :new, alert: 'Failed to update medication check.'
      end
    else
      # Create a new record if no existing record is found
      @medication_check = MedicationCheck.new(medication_check_params)
      @medication_check.drug = @drug
      @medication_check.take_time = @take_time

      if @medication_check.save
        redirect_to root_path, notice: 'Medication check was successfully created.'
      else
        render :new, alert: 'Failed to create medication check.'
      end
    end
  end
  
  def show
    @day = Date.today
    @drug = Drug.find(params[:id])
  end

  def edit
    # @day = Date.today
    # @drugs = Drug.find(params[:id])
    # @drugs = MedicationCheck.new 
    # @drugs.check.check_time.build
  end
  
  private

  def medication_check_params
    params.require(:medication_check).permit(:check, :check_time)
  end

  # def update
  #   @drug = Drug.find(params[:id])
  #   set_check_time(@drug)
  #   if @drug.update(drug_params)
  #     redirect_to @drug, notice: 'Drug was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # def drug_params
  #   params.require(:drug).permit(:drug_id, take_times_attributes: [:id, :take_time, :_destroy], medication_checks_attributes: [:id, :check, :check_time, :_destroy])
  # end

  # def set_check_time(drug)
  #   drug.medication_checks.each do |mc|
  #     mc.check_time = Date.today if mc.check
  #   end
  # end
end
