module Oauth2
  module Provider
    class OauthUserTokensController < ApplicationController
      
      def index
        @tokens = OauthToken.find_all_by_user_id(current_user_id)
      end
    
      def revoke
        token = OauthToken.find_by_id(params[:token_id])
        if token.nil?
          render :text => "User not authorized to perform this action!", :status => :bad_request
          return
        end
        if token.user_id != current_user_id.to_s
          render :text => "User not authorized to perform this action!", :status => :bad_request
          return
        end
        
        token.delete
        redirect_to :action => :index
      end
      
    end
  end
end