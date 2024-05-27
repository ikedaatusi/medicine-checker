class UserSessionsController < ApplicationController
    def new; end

    def create
      @user = login(params[:email], params[:password])
      if @user
        redirect_back_or_to medication_checks_path, success: t('ログインしました')
      else
        flash.now[:danger] = t('登録情報はありません')
        render :new
      end
    end

    def destroy
      logout
      redirect_to root_path, success: t('.success'), status: :see_other
    end
   
end
