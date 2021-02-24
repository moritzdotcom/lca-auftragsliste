class Api::V1::SessionsController < Api::V1::ApiController
  def create
    @user = User.find_by(email: params[:email])

    if @user.valid_password?(params[:password])
      sign_in @user

      render json: {
        user: current_user
      }
    else
      render json: {
        message: 'Wrong email or password'
      }
    end
  end

  def destroy

  end
end
