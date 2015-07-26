require 'rails_helper'

module SwProjectCustomerQnax
  RSpec.describe BizFormsController, type: :controller do
    routes {SwProjectCustomerQnax::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_signin)
    end
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'customer')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      
      @proj = FactoryGirl.create(:sw_project_customer_qnax_project_info)
      @proj1 = FactoryGirl.create(:sw_project_customer_qnax_project_info, project_id: @proj.project_id + 1)
      #@cust = FactoryGirl.create(:kustomerx_customer)
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids
    end
      
    render_views
    
    describe "GET 'index'" do
      it "returns all info" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwProjectCustomerQnax::BizForm.order('id')")  
        session[:user_id] = @u.id
        qs = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :last_updated_by_id => @u.id, project_info_id: @proj1.id, name: 'a new act')
        qs1 = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :last_updated_by_id => @u.id, project_info_id: @proj.id)
        get 'index' 
        expect(assigns(:biz_forms)).to match_array( [qs, qs1])       
      end
      
      it "should return for the project" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwProjectCustomerQnax::BizForm.order('id')")        
        session[:user_id] = @u.id
        qs = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :last_updated_by_id => @u.id, project_info_id: @proj.id)
        qs1 = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :last_updated_by_id => @u.id, project_info_id: @proj1.id, name: 'a new act')
        get 'index' , { project_info_id: @proj.id }
        expect(assigns(:biz_forms)).to eq([qs])
      end
      
    end
  
    describe "GET 'new'" do
      
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        get 'new' , { project_info_id: @proj.id}
        expect(response).to be_success
      end
           
    end
  
    describe "GET 'create'" do
      it "redirect for a successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        qs = FactoryGirl.attributes_for(:sw_project_customer_qnax_biz_form, project_info_id: @proj.id)
        get 'create' , {  :biz_form => qs}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        qs = FactoryGirl.attributes_for(:sw_project_customer_qnax_biz_form, :name => nil)
        get 'create' , {  :biz_form => qs}
        expect(response).to render_template("new")
      end
    end
  
    describe "GET 'edit'" do
      
      it "returns http success for edit" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        qs = FactoryGirl.create(:sw_project_customer_qnax_biz_form, project_info_id: @proj.id)
        get 'edit' , {  :id => qs.id}
        expect(response).to be_success
      end
      
    end
  
    describe "GET 'update'" do
      
      it "redirect if success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        qs = FactoryGirl.create(:sw_project_customer_qnax_biz_form, project_info_id: @proj.id)
        get 'update' , {  :id => qs.id, :biz_form => {:name => 'newnew'}}
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        qs = FactoryGirl.create(:sw_project_customer_qnax_biz_form)
        get 'update' , {  :id => qs.id, :biz_form => {:name => nil}}
        expect(response).to render_template("edit")
      end
    end
  
    describe "GET 'show'" do
      
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        qs = FactoryGirl.create(:sw_project_customer_qnax_biz_form, project_info_id: @proj.id, last_updated_by_id: @u.id)
        get 'show' , {  :id => qs.id}
        expect(response).to be_success
      end
    end
  
    describe "GET 'destroy'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'destroy', :resource =>'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        q = FactoryGirl.create(:sw_project_customer_qnax_biz_form)
        get 'destroy', { :id => q.id }
        expect(response).to redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Successfully Deleted!")
      end
    end
  
  end
end
