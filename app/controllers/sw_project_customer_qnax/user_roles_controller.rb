require_dependency "sw_project_customer_qnax/application_controller"

module SwProjectCustomerQnax
  class UserRolesController < ApplicationController
    before_filter :load_record
    
    def index
      @title = t('User Roles')
      @user_roles = params[:sw_project_customer_qnax_user_roles][:model_ar_r]
      @user_roles = @user_roles.where(user_role_id: @project_info.id) if @project_info
      @user_roles = @user_roles.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('user_role_index_view', 'sw_project_customer_qnax')
    end
  
    def new
      @title = t('New User Role')
      @user_role = SwProjectCustomerQnax::UserRole.new()
      @erb_code = find_config_const('user_role_new_view', 'sw_project_customer_qnax')
    end
  
    def create
      @user_role = SwProjectCustomerQnax::UserRole.new(params[:user_role], :as => :role_new)
      @user_role.last_updated_by_id = session[:user_id]
      @user_role.submitted_by_id = session[:user_id]
      if @user_role.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:user_role][:project_info_id]) if params[:user_role][:project_info_id].present?
        @erb_code = find_config_const('user_role_new_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update User Role')
      @user_role = SwProjectCustomerQnax::UserRole.find_by_id(params[:id])
      @erb_code = find_config_const('user_role_edit_view', 'sw_project_customer_qnax')
    end
  
    def update
      @user_role = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:id])
      @user_role.last_updated_by_id = session[:user_id]
      if @user_role.update_attributes(params[:user_role], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('user_role_edit_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
    
    def show
      @title = t('User Role Info')
      @user_role = SwProjectCustomerQnax::UserRole.find_by_id(params[:id])
      @erb_code = find_config_const('user_role_show_view', 'sw_project_customer_qnax')
    end
    
    def destroy
      SwProjectCustomerQnax::UserRole.delete(params[:id].to_i)
      redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Deleted!")
    end
    
    protected
    def load_record
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:project_id]) if params[:project_id].present?
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:id]).project_id) if params[:id].present?
    end
  
    
  end
end
