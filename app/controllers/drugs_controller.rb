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
     @drug = current_user.drugs.new(drug_params)
     
    #  sabun = (@drug.start_time - Date.today).to_i
    #  unless sabun >= 0
    #   flash[:danger] = "開始日は明日以降で！"
    #    render :new
    #    return
    #  end
    #  sabun = (@drug.end_time - @drug.start_time).to_i
    #   unless sabun <= 180
    #   flash[:danger] = "期間は最長180日間まで!"
    #   render :new
    #   return
    #   end
    #   unless sabun >= 0
    #   flash[:danger] = "終了日は開始日以降で！"
    #   render :new
    #   return
    #   end
    
      
    if @drug.save
      redirect_to drugs_path, status: :see_other, notice: "薬を登録しました"
    else
      flash.now[:danger] = t('登録できませんでした')
      render :new, status: :unprocessable_entity
    end
    
  end 

  def index
    @q = current_user.drugs.ransack(params[:q])
    @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @day = Date.today
    @drug = current_user..find(params[:id])
  end

  def update
    
    if @drug.update(drug_params)
      # set_check_time
      redirect_to "/drugs", status: :see_other, notice: "薬を編集しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
   
  end

  def destroy
    if @drug.destroy
      redirect_to drugs_path, status: :see_other, notice: "薬を削除しました"
    else
      flash.now[:alert] = "削除に失敗しました"
      render 'show'
    end
  end

  private

  def set_drug
    @drug = current_user.drugs.find(params[:id])
  end

  def drug_params
    params.require(:drug).permit(:hospital_name, :drug_name, :number_of_tablets, :image_url, :start_time, :end_time, take_times_attributes: [:id, :take_time, :_destroy], medication_checks_attributes: [:id, :check, :check_time, :take_time_id, :drug_id, :_destroy])
  end

  # def drug_param
  #   params.require(:drug).permit(:drug_id, take_times_attributes: [:id, :take_time, :_destroy], medication_checks_attributes: [:id, :check, :check_time, :_destroy])
  # end
  

#   def set_check_time
#     today = Date.today + 4
#     @drug.take_times.each do |take_time|
#       unless @drug.medication_checks.exists?(check_time: today, take_time_id: take_time.id)
#         @drug.medication_checks.build(check_time: today, take_time_id: take_time.id)
#       end
#     end
#   end
end

