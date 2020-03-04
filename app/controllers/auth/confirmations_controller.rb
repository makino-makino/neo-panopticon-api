module Auth
	class Auth::ConfirmationsController < DeviseTokenAuth::ConfirmationsController
		def show
			self.resource = resource_class.confirm_by_token(params[:confirmation_token])
			yield resource if block_given?

			if resource.errors.empty?
				render plain: 'ok'
			else
				puts resource.errors.messages
				render plain: 'token is not correct'
			end
		end
	end
end

