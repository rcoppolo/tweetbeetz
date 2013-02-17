class CallbackController < ApplicationController

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user, notice: "Success!"
    else
      redirect_to root_path, alert: "Couldn't sign you up..."
    end
  end

end
