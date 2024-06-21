class MemosController < ApplicationController
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
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    @drug = Drug.find(params[:drug_id])
    if @memo.save
      redirect_to  with_date_show_calendar_path(@drug, date: params[:date]), notice: "保存しました"
    else
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @drug = Drug.find(params[:drug_id])
    @memo = Memo.find(params[:id])
    if @memo.update(memo_params)
      
      redirect_to  with_date_show_calendar_path(@drug, date: params[:date]), notice: "Memo updated successfully."
    else
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @drug = current_user.drugs.find(params[:drug_id])
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @memo = Memo.find_by(id: params[:id], drug: @drug, create_time: @date)
    if @memo.new_record?
      flash[:notice] = "No existing memo found for this date and drug, creating a new one."
    end
  end

  def destroy
    @drug = Drug.find(params[:drug_id])
    @memo = Memo.find_by(id: params[:id])
    if @memo.destroy
      redirect_to  with_date_show_calendar_path(@drug, date: params[:date]), notice: "メモを削除しました"
    else
      flash.now[:alert] = "削除に失敗しました"
      render with_date_show_calendar_path(@drug, date: params[:date]), status: :see_other
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:drug_id, :body, :create_time)
  end
end
