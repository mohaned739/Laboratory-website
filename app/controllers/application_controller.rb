class ApplicationController < ActionController::Base
    before_action :hooks
    def hooks
        @users=User.order('id')
        @reports=Report.order('created_at DESC')
    end
end
