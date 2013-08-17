  require 'grape'

  module Api
    class Root < Grape::API

      version 'v1', using: :header, vendor: 'bookmarkie'
      prefix 'api'
      format :json  
      formatter :json, Grape::Formatter::Rabl

      helpers do
       def warden
        env['warden']
       end

      def authenticated?
        if warden.authenticated?
          return true
        elsif params[:auth_token] and
          User.find_by_authentication_token(params[:auth_token]) and
          User.find_by_authentication_token(params[:auth_token]).auth_token_expiry > DateTime.now
          return true
        else
          error!({"error" => "Unauth 401. Token invalid or expired"}, 401)
        end
      end

      def current_user
        warden.user ||  User.find_by_authentication_token(params[:auth_token])
      end
    end

  end
end