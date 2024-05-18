class DrugsController < ApplicationController

  def new
    @drug = Drug.new
    @drug.take_times.build
    # @index = Time.now.to_i
  end

  def create
     @drugs = current_user.drugs.build(drug_params)
     
     sabun = (@drugs.start_time - Date.today).to_i
     unless sabun >= 1
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
    # @user = User.find(params[:id])
    # @q = Drug.ransack(params[:q])
    # @drugs = @q.result(distinct: true).includes(%i[user drugs]).order(created_at: :desc).page(params[:page])
    @drugs = @q.result(distinct: true).includes(:take_times).order(created_at: :desc).page(params[:page])
    #          .order("start_times.created_at DESC")
    # @drugs = Drug.joins(:start_time).select("drugs.*", "start_times.*")         
    # @drugs = Drug.take_times
  end

  def show
    @drug = Drug.find(params[:id])
  end

  def update
    @drugs = Drug.find(params[:id])
    if @drugs.update(drug_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @drug = Drug.find(params[:id])
  end

  def destroy
    @drug = Drug.find(params[:id])
    if @drug.destroy
      redirect_to root_path, status: :see_other, notice: "薬を削除しました"
    else
      flash.now[:danger] = "削除に失敗しました"
      render 'show'
    end
  end


  def drug_params
    params.require(:drug).permit(:hospital_name, :drug_name, :number_of_tablets, :image_url, :start_time, :end_time, take_times_attributes: [:id, :take_time, :_destroy] )
  end
end

