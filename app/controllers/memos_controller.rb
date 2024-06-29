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
    @date = params[:date]
    if @memo.save
      flash.now[:alert] = "レビューを投稿しました"
      # render turbo_stream: [
      #   turbo_stream.prepend(@memo),
      #   turbo_stream.update("flash", partial: "shared/flash_message")
      # ]
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('memos', partial: 'memos/memo', locals: { memo: @memo }),
            turbo_stream.replace('flash', partial: 'shared/flash_message'),
          ]
        end
        
        format.html { redirect_to with_date_show_calendar_path(@drug, date: params[:date]), notice: "メモが正常に作成されました。" }
      end
  
      # redirect_to  with_date_show_calendar_path(@drug, date: params[:date]), notice: "保存しました"
    else
      # @date = params[:date] ? Date.parse(params[:date]) : Date.today
      # render :new, status: :unprocessable_entity
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("drug_modal", partial: "memos/flash_message", locals: { memo: @memo }) }
        format.html { render :new }
      end
    end
  end

  def update
    @drug = Drug.find(params[:drug_id])
    @memo = Memo.find(params[:id])
    @date = params[:date]
    if @memo.update(memo_params)
      flash.now[:alert] = "更新に成功しました"
      render turbo_stream: [
        turbo_stream.update(@memo),
        turbo_stream.update("flash", partial: "shared/flash_message")
      ]
      # redirect_to  with_date_show_calendar_path(@drug, date: params[:date]), notice: "Memo updated successfully."
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
    # @drug = Drug.find(params[:drug_id])
    @memo = Memo.find_by(id: params[:id])
    @date = params[:date]
  if @memo&.destroy
    flash.now[:notice] = "削除に成功しました"
    render turbo_stream: [
      turbo_stream.remove(@memo),
      turbo_stream.update("flash", partial: "shared/flash_message")
    ]
  else
    flash.now[:alert] = "削除に失敗しました"
    @drug = Drug.find(params[:drug_id])
    render turbo_stream: turbo_stream.replace("memo_#{params[:id]}", partial: "memos/memo_not_found"), status: :see_other
  end
  end

  private

  def memo_params
    params.require(:memo).permit(:drug_id, :body, :create_time)
  end
end
