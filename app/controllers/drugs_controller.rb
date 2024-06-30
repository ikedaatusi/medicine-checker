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
    if @drug.valid? && @drug.take_times.any? { |tt| tt.take_time.present? }
      if @drug.save
        redirect_to medication_checks_path, status: :see_other, notice: "薬を登録しました"
      else
        render :new, status: :unprocessable_entity
      end
    else
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
      render :edit, status: :unprocessable_entity
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

  def search
    @drug_names = DrugName.where("drug_name LIKE ?", "%#{params[:q]}%").limit(10)
    respond_to do |format|
      format.json { render json: @drug_names }
    end
  end

  private

  def set_drug
    @drug = current_user.drugs.find(params[:id])
  end

  def drug_params
    params.require(:drug).permit(:hospital_name, :drug_name, :number_of_tablets, :image_url, :start_time, :end_time, take_times_attributes: [:id, :take_time, :_destroy], medication_checks_attributes: [:id, :check, :check_time, :take_time_id, :drug_id, :_destroy])
  end
end

