module Auth
	class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
		before_action :skip_session
		protected
		def skip_session
			request.session_options[:skip] = true
		end



		private
		def sign_up_params
			params.require(:name)
			params.require(:phone)
			params.require(:password)
			params.require(:email)
			params.permit(:name, :phone, :email, :password, :password_confirmation, :bio)
		end
		def account_update_params
			params.permit(:name, :email, :phone, :image, :bio)
		end
	end
end

