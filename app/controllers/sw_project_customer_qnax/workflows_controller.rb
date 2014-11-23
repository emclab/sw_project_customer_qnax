require_dependency "sw_project_customer_qnax/application_controller"

module SwProjectCustomerQnax
  class WorkflowsController < ApplicationController
    before_filter :load_record
    
    def index
      @title = t('Workflows')
      @workflows = params[:sw_project_customer_qnax_workflows][:model_ar_r]
      @workflows = @workflows.where(project_info_id: @project_info.id) if @project_info
      @workflows = @workflows.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('workflow_index_view', 'sw_project_customer_qnax')
    end
  
    def new
      @title = t('New Workflow')
      @workflow = SwProjectCustomerQnax::Workflow.new()
      @workflow.workflow_steps.build
      @user_roles = SwProjectCustomerQnax::UserRole.scoped
      @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
      @erb_code = find_config_const('workflow_new_view', 'sw_project_customer_qnax')
      @erb_code_field = find_config_const('workflow_new_view_field', 'sw_project_customer_qnax')
    end
  
    def create
      @workflow = SwProjectCustomerQnax::Workflow.new(params[:workflow], :as => :role_new)
      @workflow.last_updated_by_id = session[:user_id]
      if @workflow.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:workflow][:project_info_id]) if params[:workflow][:project_info_id].present?
        @user_roles = SwProjectCustomerQnax::UserRole.scoped
        @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
        @erb_code = find_config_const('workflow_new_view', 'sw_project_customer_qnax')
        @erb_code_field = find_config_const('workflow_new_view_field', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Workflow')
      @workflow = SwProjectCustomerQnax::Workflow.find_by_id(params[:id])
      @user_roles = SwProjectCustomerQnax::UserRole.scoped
      @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
      @erb_code = find_config_const('workflow_edit_view', 'sw_project_customer_qnax')
    end
  
    def update
      @workflow = SwProjectCustomerQnax::Workflow.find_by_id(params[:id])
      @workflow.last_updated_by_id = session[:user_id]
      if @workflow.update_attributes(params[:workflow], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:workflow][:project_info_id]) if params[:workflow][:project_info_id].present?
        @user_roles = SwProjectCustomerQnax::UserRole.scoped
        @biz_forms = SwProjectCustomerQnax::BizForm.where(project_info_id: @project_info.id)
        @erb_code = find_config_const('workflow_edit_view', 'sw_project_customer_qnax')
        @erb_code_field = find_config_const('workflow_new_view_field', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
    
    def show
      @title = t('Workflow Info')
      @workflow = SwProjectCustomerQnax::Workflow.find_by_id(params[:id])
      @erb_code = find_config_const('workflow_show_view', 'sw_project_customer_qnax')
    end
  
    def destroy
      SwProjectCustomerQnax::Workflow.delete(params[:id].to_i)
      redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Deleted!")
    end
    
    protected
    def load_record
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:project_info_id]) if params[:project_info_id].present?
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(SwProjectCustomerQnax::Workflow.find_by_id(params[:id]).project_info_id) if params[:id].present?
    end
  end
end
