require 'spec_helper'

module SwProjectCustomerQnax
  describe WorkflowsController do
  
    before(:each) do
      controller.should_receive(:require_signin)
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
      
    end
      
    render_views
    
    describe "GET 'index'" do
      it "returns all info" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwProjectCustomerQnax::Workflow.scoped.order('id')")  
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_workflow, :last_updated_by_id => @u.id, project_info_id: @proj1.id, name: 'a new act')
        qs1 = FactoryGirl.create(:sw_project_customer_qnax_workflow, :last_updated_by_id => @u.id, project_info_id: @proj.id)
        get 'index' , {:use_route => :sw_project_customer_qnax}
        assigns(:workflows).should =~ [qs, qs1]       
      end
      
      it "should return for the project" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwProjectCustomerQnax::Workflow.scoped.order('id')")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_workflow, :last_updated_by_id => @u.id, project_info_id: @proj.id)
        qs1 = FactoryGirl.create(:sw_project_customer_qnax_workflow, :last_updated_by_id => @u.id, project_info_id: @proj1.id, name: 'a new act')
        get 'index' , {:use_route => :sw_project_customer_qnax, project_info_id: @proj.id }
        assigns(:workflows).should eq([qs])
      end
      
    end
  
    describe "GET 'new'" do
      
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new', {:use_route => :sw_project_customer_qnax, project_info_id: @proj.id}
        response.should be_success
      end
           
    end
  
    describe "GET 'create'" do
      it "redirect for a successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        role = FactoryGirl.create(:sw_project_customer_qnax_user_role)
        qss = FactoryGirl.attributes_for(:sw_project_customer_qnax_workflow_step)
        qs = FactoryGirl.attributes_for(:sw_project_customer_qnax_workflow, project_info_id: @proj.id, workflow_steps_attributes: [qss])
        get 'create' , {:use_route => :sw_project_customer_qnax,  :workflow => qs}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        role = FactoryGirl.create(:sw_project_customer_qnax_user_role)
        qss = FactoryGirl.attributes_for(:sw_project_customer_qnax_workflow_step)
        qs = FactoryGirl.attributes_for(:sw_project_customer_qnax_workflow, :name => nil, workflow_steps_attributes: [qss])
        get 'create' , {:use_route => :sw_project_customer_qnax,  :workflow => qs}
        response.should render_template("new")
      end
    end
  
    describe "GET 'edit'" do
      
      it "returns http success for edit" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_workflow, project_info_id: @proj.id)
        get 'edit' , {:use_route => :sw_project_customer_qnax,  :id => qs.id}
        response.should be_success
      end
      
    end
  
    describe "GET 'update'" do
      
      it "redirect if success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_workflow, project_info_id: @proj.id)
        get 'update' , {:use_route => :sw_project_customer_qnax,  :id => qs.id, :workflow => {:name => 'newnew'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_workflow)
        get 'update' , {:use_route => :sw_project_customer_qnax,  :id => qs.id, :workflow => {:biz_form_id => nil}}
        response.should render_template("edit")
      end
    end
  
    describe "GET 'show'" do
      
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        form = FactoryGirl.create(:sw_project_customer_qnax_biz_form)
        role = FactoryGirl.create(:sw_project_customer_qnax_user_role)
        qs = FactoryGirl.create(:sw_project_customer_qnax_workflow_step, user_role_id: role.id)
        q = FactoryGirl.create(:sw_project_customer_qnax_workflow, :workflow_steps => [qs], biz_form_id: form.id)
        get 'show' , {:use_route => :sw_project_customer_qnax,  :id => qs.id}
        response.should be_success
      end
    end
  
    describe "GET 'destroy'" do
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'destroy', :resource =>'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        role = FactoryGirl.create(:sw_project_customer_qnax_user_role)
        qs = FactoryGirl.create(:sw_project_customer_qnax_workflow_step)
        q = FactoryGirl.create(:sw_project_customer_qnax_workflow, :workflow_steps => [qs])
        get 'destroy', {:use_route => :sw_project_customer_qnax, :id => q.id }
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Deleted!")
      end
    end
  
  end
end
