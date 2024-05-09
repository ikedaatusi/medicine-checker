class DrugsController < ApplicationController

  def new
    @drug = Drug.new
    @drug.take_times.build
    # @index = Time.now.to_i
  end

  def create
     @drugs = current_user.drugs.build(drug_params)
    if @drugs.save
      redirect_to root_path
    else
      render :new
    end
  end 

  def index
    @q = Drug.ransack(params[:q])
    @drugs = @q.result(distinct: true).includes(%i[user drugs]).order(created_at: :desc).page(params[:page])
  end

  def show
    @drug = Drug.find(params[:id])
  end

  def update
    if @drug.update(user_params)
      redirect_to root_path
    else
      render :new_drugs_path
    end
  end

  def edit
  end

  def destroy
    @drugs.destroy!
    redirect_to root_path, status: :see_other

  end


  def drug_params
    params.require(:drug).permit(:hospital_name, :drug_name, :number_of_tablets, :image_url, :start_time, :end_time, take_times_attributes: [:id, :take_time, :_destroy] )
  end
end