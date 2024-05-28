class UsersController < ApplicationController
 
  
   def new
     @user = User.new
   end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('登録しました')
    else
      flash.now[:danger] = t('登録できませんでした')
      render :new
    end
  end

  private

  def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

