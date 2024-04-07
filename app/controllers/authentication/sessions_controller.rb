module Authentication
  class SessionsController < ApplicationController
    skip_before_action :require_session, only: %i[new create]

    def new; end

    def create
      @user = User.find_by(email: params[:email])

      if @user&.authenticate(params[:password])
        create_session(@user)
        redirect_to private_url, notice: I18n.t("sessions.notices.created")
      else
        flash.now[:error] = I18n.t("sessions.notices.failed")
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      destroy_session
      redirect_to sign_in_path, notice: I18n.t("sessions.notices.destroyed")
    end
  end
end
