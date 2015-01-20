require_dependency "sw_project_customer_qnax/application_controller"

module SwProjectCustomerQnax
  class ProjectInfosController < ApplicationController
    before_filter :load_record
    
    def index
      @title = t('Project Infos')
      @project_infos = params[:sw_project_customer_qnax_project_infos][:model_ar_r]
      @project_infos = @project_infos.where(customer_id: @customer.id) if @customer
      @project_infos = @project_infos.where(project_id: @project.id) if @project
      @project_infos = @project_infos.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('project_info_index_view', 'sw_project_customer_qnax')
    end
  
    def new
      @title = t('New Project Info')
      @project_info = SwProjectCustomerQnax::ProjectInfo.new()
      @erb_code = find_config_const('project_info_new_view', 'sw_project_customer_qnax')
    end
  
    def create
      @project_info = SwProjectCustomerQnax::ProjectInfo.new(params[:project_info], :as => :role_new)
      @project_info.last_updated_by_id = session[:user_id]
      @project_info.submitted_by_id = session[:user_id]
      if @project_info.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @project = SwProjectCustomerQnax.project_class.find_by_id(params[:project_info][:project_id]) if params[:project_info][:project_id].present?
        @customer = SwProjectCustomerQnax.customer_class.find_by_id(params[:project_info][:customer_id]) if params[:project_info][:customer_id].present?
        @erb_code = find_config_const('project_info_new_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Project Info')
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:id])
      @erb_code = find_config_const('project_info_edit_view', 'sw_project_customer_qnax')
    end
  
    def update
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:id])
      @project_info.last_updated_by_id = session[:user_id]
      if @project_info.update_attributes(params[:project_info], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('project_info_edit_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
    
    def show
      @title = t('Project Info')
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:id])
      @erb_code = find_config_const('project_info_show_view', 'sw_project_customer_qnax')
    end
    
    protected
    def load_record
      @customer = SwProjectCustomerQnax.customer_class.find_by_id(params[:customer_id].to_i) if params[:customer_id].present?
      @customer = SwProjectCustomerQnax.customer_class.find_by_id(SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:id].to_i).customer_id) if params[:id].present?
      @customer = SwProjectCustomerQnax.customer_class.find_by_id(session[:session_customer_id]) if session[:session_customer_id].present?
      @project = SwProjectCustomerQnax.project_class.find_by_id(params[:project_id]) if params[:project_id].present?
      @project = SwProjectCustomerQnax.project_class.find_by_id(SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:id]).project_id) if params[:id].present?
      @sw_projects = SwProjectCustomerQnax.project_class.where(customer_id: @customer.id) if @customer
    end
     
  end
end
