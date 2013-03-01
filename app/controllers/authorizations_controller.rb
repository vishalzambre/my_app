class AuthorizationsController < ApplicationController
	def create
		omniauth = request.env['omniauth.auth']		
		@auth = Authorization.find_from_hash(omniauth)
      
      if current_user
        flash[:notice] = "Successfully added #{omniauth['provider']} authentication"
        current_user.authorizations.create(:provider => omniauth['provider'], :uid => omniauth['uid']) #Add an auth to existing user
      elsif @auth
        flash[:notice] = "Welcome back #{omniauth['provider']} user"
      else
        @new_auth = Authorization.create_from_hash(omniauth, current_user) #Create a new user
        flash[:notice] = "Welcome #{omniauth['provider']} user. Your account has been created."
      end

      existing_auth = Authorization.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first    
      #  resource = existing_auth.user
      # existing_auth.user.ensure_authentication_token!

      # session["warden.user.user.key"] = ["User", [existing_auth.user_id], "#{existing_auth.user.encrypted_password}"]
      # puts "==========#{session["warden.user.user.key"]}"
	  sign_in existing_auth.user
	  puts "==========#{session["warden.user.user.key"]}"
      redirect_to session["user_return_to"] || request.env['rack.session'][:return_to] || '/'
	end
	
	def failure

      flash[:notice] = "Sorry, You din't authorize"
      redirect_to session["user_return_to"] || request.referer || '/'

    end
end
 

   