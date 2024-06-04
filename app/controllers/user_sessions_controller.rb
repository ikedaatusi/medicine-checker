class UserSessionsController < ApplicationController
    def new; end

    def create
      @user = login(params[:email], params[:password])
      if @user
        redirect_back_or_to medication_checks_path, notice: "ログインしました"
      else
        flash.now[:alert] = "登録情報はありません"
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      logout
      redirect_to root_path, status: :see_other, notice: "ログアウトしました"
    end
   
    def guest_login
    if current_user
      redirect_to current_user, alert: "すでにログインしています"  # ログインしている場合はゲストユーザーを作成しない
    else
      user = User.guest_login
      log_in user
      redirect_to user, notice: "ゲストとしてログインしました"
    end
  end
end
