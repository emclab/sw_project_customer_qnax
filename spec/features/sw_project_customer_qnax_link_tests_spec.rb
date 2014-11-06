require 'spec_helper'

describe "LinkTests" do
  describe "GET /sw_project_customer_qnax_link_tests" do
    mini_btn = 'btn btn-mini '
    ActionView::CompiledTemplates::BUTTONS_CLS =
        {'default' => 'btn',
         'mini-default' => mini_btn + 'btn',
         'action'       => 'btn btn-primary',
         'mini-action'  => mini_btn + 'btn btn-primary',
         'info'         => 'btn btn-info',
         'mini-info'    => mini_btn + 'btn btn-info',
         'success'      => 'btn btn-success',
         'mini-success' => mini_btn + 'btn btn-success',
         'warning'      => 'btn btn-warning',
         'mini-warning' => mini_btn + 'btn btn-warning',
         'danger'       => 'btn btn-danger',
         'mini-danger'  => mini_btn + 'btn btn-danger',
         'inverse'      => 'btn btn-inverse',
         'mini-inverse' => mini_btn + 'btn btn-inverse',
         'link'         => 'btn btn-link',
         'mini-link'    => mini_btn +  'btn btn-link'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'customer')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SwProjectCustomerQnax::ProjectInfo.scoped.order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "record.last_updated_by_id == session[:user_id]")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "record.last_updated_by_id == session[:user_id]")
      ua1 = FactoryGirl.create(:user_access, :action => 'project_member', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create_project', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'index_for_customer', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "SwProjectCustomerQnax::ProjectInfo.scoped.order('id')")  
        
      
      @proj = FactoryGirl.create(:sw_project_customer_qnax_project_info)
      @cust = FactoryGirl.create(:kustomerx_customer)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur], :customer_id => @cust.id)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => 'password'
      click_button 'Login'
      
    end
    it "works! (now write some real specs)" do
      qs = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, :customer_id => @cust.id)
      visit project_infos_path()      
      click_link 'Edit'
      save_and_open_page
      page.should have_content('Edit Project Info')
      fill_in 'project_name', with: 'a new name'
      click_button 'Save'
      save_and_open_page
      #bad data
      visit project_infos_path()      
      click_link 'Edit'
      fill_in 'project_name', with: ''
      click_button 'Save'
      save_and_open_page
      #
      visit project_infos_path(:customer_id => @cust.id)
      save_and_open_page
      page.should have_content('Project Infos')
      click_link 'New Project'
      fill_in 'project_name', with: 'a name'
      select('proj status', from: 'project_status_id')
      click_button 'Save'
      save_and_open_page
      #bad data
      visit project_infos_path(customer_id: @cust.id)
      click_link 'New Project'
      fill_in 'project_name', with: 'a new name'
      click_button 'Save'
      save_and_open_page
      #
      visit project_infos_path
      save_and_open_page
      page.should have_content('Project Infos')
      click_link 'New Project'
      save_and_open_page
      page.should have_content('New Project Info')
      visit project_infos_path
      click_link qs.id.to_s
      page.should have_content('Project Info')
      click_link 'New Log'
      page.should have_content('Log')
      #save_and_open_page
      
    end
    
  end
end
