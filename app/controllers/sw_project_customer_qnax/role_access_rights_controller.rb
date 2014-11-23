require_dependency "sw_project_customer_qnax/application_controller"

module SwProjectCustomerQnax
  class RoleAccessRightsController < ApplicationController
    before_filter :load_record
    
    def index
      @title = t('Role Access Rights')
      @role_access_rights = params[:sw_project_customer_qnax_role_access_rights][:model_ar_r]
      @role_access_rights = @role_access_rights.where(project_info_id: @project_info.id) if @project_info
      @role_access_rights = @role_access_rights.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('role_access_right_index_view', 'sw_project_customer_qnax')
    end
  
    def new
      @title = t('New Role Access Right')
      @role_access_right = SwProjectCustomerQnax::RoleAccessRight.new()
      @user_roles = SwProjectCustomerQnax::UserRole.where(project_info_id: @project_info.id)
      @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
      @erb_code = find_config_const('role_access_right_new_view', 'sw_project_customer_qnax')
    end
  
    def create
      @role_access_right = SwProjectCustomerQnax::RoleAccessRight.new(params[:role_access_right], :as => :role_new)
      @role_access_right.last_updated_by_id = session[:user_id]
      if @role_access_right.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:role_access_right][:project_info_id]) if params[:role_access_right][:project_info_id].present?
        @user_roles = SwProjectCustomerQnax::UserRole.where(project_info_id: @project_info.id)
        @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
        @erb_code = find_config_const('role_access_right_new_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Role Access Right')
      @role_access_right = SwProjectCustomerQnax::RoleAccessRight.find_by_id(params[:id])
      @user_roles = SwProjectCustomerQnax::UserRole.where(project_info_id: @project_info.id)
      @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
      @erb_code = find_config_const('role_access_right_edit_view', 'sw_project_customer_qnax')
    end
  
    def update
      @role_access_right = SwProjectCustomerQnax::RoleAccessRight.find_by_id(params[:id])
      @role_access_right.last_updated_by_id = session[:user_id]
      if @role_access_right.update_attributes(params[:role_access_right], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(@role_access_right.project_info_id)
        @user_roles = SwProjectCustomerQnax::UserRole.where(project_info_id: @project_info.id)
        @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
        @erb_code = find_config_const('role_access_right_edit_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
    
    def show
      @title = t('Role Access Right Info')
      @role_access_right = SwProjectCustomerQnax::RoleAccessRight.find_by_id(params[:id])
      @erb_code = find_config_const('role_access_right_show_view', 'sw_project_customer_qnax')
    end
    
    def destroy
      SwProjectCustomerQnax::RoleAccessRight.delete(params[:id].to_i)
      redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Deleted!")
    end
    
    protected
    def load_record
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:project_info_id]) if params[:project_info_id].present?
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(SwProjectCustomerQnax::RoleAccessRight.find_by_id(params[:id]).project_info_id) if params[:id].present?
    end
  end
end
