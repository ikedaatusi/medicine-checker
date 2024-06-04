class UsersController < ApplicationController
 
  
   def new
     @user = User.new
   end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, status: :see_other, notice: "登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def guest_login
    @user = User.create(
    name: 'ゲスト',
    email: SecureRandom.alphanumeric(10) + "@email.com",
    password: 'password',
    password_confirmation: 'password'
    )
    auto_login(@user)
    redirect_back_or_to medication_checks_path, success: 'ゲストとしてログインしました'
  end

  private

  def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

