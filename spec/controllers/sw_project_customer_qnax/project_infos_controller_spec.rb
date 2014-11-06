require 'spec_helper'

module SwProjectCustomerQnax
  describe ProjectInfosController do
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
      
      @proj = FactoryGirl.create(:info_service_projectx_project)
      @cust = FactoryGirl.create(:kustomerx_customer)
      
    end
      
    render_views
    
    describe "GET 'index'" do
      it "returns all info for the customer" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwProjectCustomerQnax::ProjectInfo.scoped.order('id')")  
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id)
        qs1 = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id,  :name => 'newnew',)
        get 'index' , {:use_route => :sw_project_customer_qnax}
        assigns(:project_infos).should =~ [qs, qs1]       
      end
      
      it "should return project for the category_id" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwProjectCustomerQnax::ProjectInfo.scoped.order('id')")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, :category_id => @cate.id)
        qs1 = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, :category_id => @cate.id + 1, :name => 'newnew')
        get 'index' , {:use_route =>  :sw_module_infox, :category_id => @cate.id }
        assigns(:project_infos).should eq([qs])
      end
      
    end
  
    describe "GET 'new'" do
      
      it "returns http success" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        get 'new' , {:use_route => :sw_project_customer_qnax}
        response.should be_success
      end
           
    end
  
    describe "GET 'create'" do
      it "redirect for a successful creation" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.attributes_for(:sw_project_customer_qnax_project_info)
        get 'create' , {:use_route => :sw_project_customer_qnax,  :project_info => qs}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Saved!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.attributes_for(:sw_project_customer_qnax_project_info, :project_id => nil)
        get 'create' , {:use_route => :sw_project_customer_qnax,  :project_info => qs}
        response.should render_template("new")
      end
    end
  
    describe "GET 'edit'" do
      
      it "returns http success for edit" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_project_info)
        get 'edit' , {:use_route => :sw_project_customer_qnax,  :id => qs.id}
        response.should be_success
      end
      
    end
  
    describe "GET 'update'" do
      
      it "redirect if success" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_project_info, :data_resources => [resource])
        get 'update' , {:use_route => :sw_project_customer_qnax,  :id => qs.id, :project_info => {:goal => 'newnew'}}
        response.should redirect_to URI.escape(SUBURI + "/authentify/view_handler?index=0&msg=Successfully Updated!")
      end
      
      it "should render 'new' if data error" do
        user_access = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_project_info)
        get 'update' , {:use_route => :sw_project_customer_qnax,  :id => qs.id, :project_info => {:customer_id => nil}}
        response.should render_template("edit")
      end
    end
  
    describe "GET 'show'" do
      
      it "should show" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")        
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        qs = FactoryGirl.create(:sw_project_customer_qnax_project_info)
        get 'show' , {:use_route => :sw_project_customer_qnax,  :id => qs.id}
        response.should be_success
      end
    end
  end
end
