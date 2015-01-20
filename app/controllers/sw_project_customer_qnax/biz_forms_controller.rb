require_dependency "sw_project_customer_qnax/application_controller"

module SwProjectCustomerQnax
  class BizFormsController < ApplicationController
    before_filter :load_record
    
    def index
      @title = t('Biz Forms')
      @biz_forms = params[:sw_project_customer_qnax_biz_forms][:model_ar_r]
      @biz_forms = @biz_forms.where(project_info_id: @project_info.id) if @project_info
      @biz_forms = @biz_forms.page(params[:page]).per_page(@max_pagination)
      @erb_code = find_config_const('biz_form_index_view', 'sw_project_customer_qnax')
    end
  
    def new
      @title = t('New Biz Form')
      @biz_form = SwProjectCustomerQnax::BizForm.new()
      @erb_code = find_config_const('biz_form_new_view', 'sw_project_customer_qnax')
    end
  
    def create
      @biz_form = SwProjectCustomerQnax::BizForm.new(params[:biz_form], :as => :role_new)
      @biz_form.last_updated_by_id = session[:user_id]
      if @biz_form.save
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      else
        @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:biz_form][:project_info_id]) if params[:biz_form][:project_info_id].present?
        @erb_code = find_config_const('biz_form_new_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Saved!')
        render 'new'
      end
    end
  
    def edit
      @title = t('Update Biz Form')
      @biz_form = SwProjectCustomerQnax::BizForm.find_by_id(params[:id])
      @erb_code = find_config_const('biz_form_edit_view', 'sw_project_customer_qnax')
    end
  
    def update
      @biz_form = SwProjectCustomerQnax::BizForm.find_by_id(params[:id])
      @biz_form.last_updated_by_id = session[:user_id]
      if @biz_form.update_attributes(params[:biz_form], :as => :role_update)
        redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      else
        @erb_code = find_config_const('biz_form_edit_view', 'sw_project_customer_qnax')
        flash[:notice] = t('Data Error. Not Updated!')
        render 'edit'
      end
    end
    
    def show
      @title = t('Biz Form Info')
      @biz_form = SwProjectCustomerQnax::BizForm.find_by_id(params[:id])
      @erb_code = find_config_const('biz_form_show_view', 'sw_project_customer_qnax')
    end
    
    def destroy
      SwProjectCustomerQnax::BizForm.delete(params[:id].to_i)
      redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Deleted!")
    end
    
    protected
    def load_record
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(params[:project_info_id]) if params[:project_info_id].present?
      @project_info = SwProjectCustomerQnax::ProjectInfo.find_by_id(SwProjectCustomerQnax::BizForm.find_by_id(params[:id]).project_info_id) if params[:id].present?
    end
  
  end
end
