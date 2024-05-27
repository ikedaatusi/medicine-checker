class DrugsController < ApplicationController
  before_action :set_drug, only: [:edit, :update, :show, :destroy]
  before_action :require_login
  def new
    @day = Date.today
    @next_day = @day + 1
    @drug = Drug.new
    @drug.take_times.build
    # @index = Time.now.to_i
  end

  def create
     @drugs = current_user.drugs.build(drug_params)
     
     sabun = (@drugs.start_time - Date.today).to_i
     unless sabun >= 0
      flash[:error] = "開始日は明日以降で！"
       render :new
       return
     end
     sabun = (@drugs.end_time - @drugs.start_time).to_i
      unless sabun <= 180
      flash[:error] = "期間は最長180日間まで!"
      render :new
      return
      end
      unless sabun >= 0
      flash[:error] = "終了日は開始日以降で！"
      render :new
      return
      end
    
      
    if @drugs.save
      redirect_to root_path
    else
      render :new
    end
    
  end 

  def index
    @q = Drug.ransack(params[:q])
    @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page]).per(21)
  end

  def show
    @day = Date.today
    @drug = Drug.find(params[:id])
  end

  def update
    
    if @drug.update(drug_params)
      # set_check_time
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
   
  end

  def destroy
    if @drug.destroy
      redirect_to root_path, status: :see_other, notice: "薬を削除しました"
    else
      flash.now[:danger] = "削除に失敗しました"
      render 'show'
    end
  end

  private

  def set_drug
    @drug = Drug.find(params[:id])
  end

  def drug_params
    params.require(:drug).permit(:hospital_name, :drug_name, :number_of_tablets, :image_url, :start_time, :end_time, take_times_attributes: [:id, :take_time, :_destroy], medication_checks_attributes: [:id, :check, :check_time, :take_time_id, :drug_id, :_destroy])
  end

  # def drug_param
  #   params.require(:drug).permit(:drug_id, take_times_attributes: [:id, :take_time, :_destroy], medication_checks_attributes: [:id, :check, :check_time, :_destroy])
  # end

  def set_check_time
    today = Date.today + 4
    @drug.take_times.each do |take_time|
      unless @drug.medication_checks.exists?(check_time: today, take_time_id: take_time.id)
        @drug.medication_checks.build(check_time: today, take_time_id: take_time.id)
      end
    end
  end
end
