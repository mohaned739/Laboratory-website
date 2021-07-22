class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
    end

    def login
        user = @users.find_by(national_id: params[:NID])
        if user.authenticate(params[:pass])
            secret_key = Rails.application.secrets.secret_key_base[0]
            $token=JWT.encode({user_id: user.id}, secret_key)
            # render json: {token: @token}
            redirect_to home_path
        else
            flash[:alert] = 'Invalid National ID or Password'
            redirect_to root_path
        end
    end

    def create
        if  params[:pass] == params[:cpass]
        user=User.create(
           name: params[:name],
           email: params[:email],
           password: params[:pass],
           phone: params[:phone],
           national_id: params[:NID],
       )
        if user.save
            flash[:notice] = 'Registered Successfully'
            redirect_to root_path
        else
            # render json: {status: 'Error', message: 'Could not register',data: user.errors},status: :unauthorized
            flash[:alert] = 'Please follow the registeration requirments, if you did then National ID or E-mail already exists'
            redirect_to register_path
        end
    else
        flash[:alert] = 'Password and Confirmation Password are not the same'
        redirect_to register_path
    end
    end

    def register

    end
    def reports
        secret_key=Rails.application.secrets.secret_key_base[0]
        decoded_token= JWT.decode($token,secret_key)[0]
        @user = @users.find(decoded_token["user_id"])
        @reports2 = @reports.where(user_id: decoded_token["user_id"])
        # render json: {data: @reports2}
    end

    def add_report

    end

    def create_report
            user = @users.find_by(national_id: params[:NID])
            secret_key=Rails.application.secrets.secret_key_base[0]
            decoded_token= JWT.decode($token,secret_key)[0]
            doc = @users.find(decoded_token["user_id"])
            report=Report.create(
               rbc_count: params[:RBCs],
               wbc_count: params[:WBCs],
               plat_count: params[:Platlets],
               comment: params[:comment],
               user_id:user.id ,
               doc_id: doc.id
           )
            if report.save
                flash[:notice] = 'Report Saved Successfully'
                redirect_to addreport_path
            else
                # render json: {status: 'Error', message: 'Could not register',data: user.errors},status: :unauthorized
                flash[:alert] = 'Error'
                redirect_to addreport_path
            end
    end

    def home
        secret_key=Rails.application.secrets.secret_key_base[0]
        decoded_token= JWT.decode($token,secret_key)[0]
        @user = @users.find(decoded_token["user_id"])
    end

    def logout
        $token=0
        redirect_to root_path
    end
end
