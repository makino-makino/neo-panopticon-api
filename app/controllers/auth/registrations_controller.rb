module Auth
	class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
		private
		def sign_up_params
			params.require(:name)
			params.require(:phone)
			params.permit(:name, :phone, :email, :password, :password_confirmation)
		end
		def account_update_params
			params.permit(:name, :email, :phone, :image)
		end
	end
end

