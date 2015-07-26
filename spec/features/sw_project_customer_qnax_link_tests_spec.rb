require 'rails_helper'

RSpec.describe "LinkTests", type: :request do
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
         'mini-link'    => mini_btn +  'btn btn-link',
         'right-span#'         => '2', 
               'left-span#'         => '6', 
               'offset#'         => '2',
               'form-span#'         => '4'
        }
    before(:each) do
      @pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'customer')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      
      #project info
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SwProjectCustomerQnax::ProjectInfo.order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'sw_project_customer_qnax_project_infos', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create_project_customer_info', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      #biz_form
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SwProjectCustomerQnax::BizForm.order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'sw_project_customer_qnax_biz_forms', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create_project', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      #role access right
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_role_access_rights', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SwProjectCustomerQnax::RoleAccessRight.order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_role_access_rights', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_role_access_rights', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'sw_project_customer_qnax_role_access_rights', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      #user role
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_user_roles', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SwProjectCustomerQnax::UserRole.order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_user_roles', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_user_roles', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'sw_project_customer_qnax_user_roles', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      #workflow
      ua1 = FactoryGirl.create(:user_access, :action => 'index', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "SwProjectCustomerQnax::Workflow.order('id')")
      ua1 = FactoryGirl.create(:user_access, :action => 'create', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      ua1 = FactoryGirl.create(:user_access, :action => 'update', :resource => 'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
           :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'show', :resource =>'sw_project_customer_qnax_workflows', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      user_access = FactoryGirl.create(:user_access, :action => 'create_customer_workflow', :resource => 'commonx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
      
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      @projj = FactoryGirl.create(:info_service_projectx_project)
      @projj1 = FactoryGirl.create(:info_service_projectx_project, :name => 'a new name')
      @cust = FactoryGirl.create(:kustomerx_customer)
      
      visit '/'
      #save_and_open_page
      fill_in "login", :with => @u.login
      fill_in "password", :with => @u.password
      click_button 'Login'
      
    end
    it "works for project info" do
      qp = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, project_id: @projj.id)
      visit sw_project_customer_qnax.project_infos_path()      
      click_link 'Edit'
      #save_and_open_page
      expect(page).to have_content('Update Project Info')
      #fill_in 'project_name', with: 'a new name'
      select('a new name', :from => 'project_info_project_id')
      click_button 'Save'
      #save_and_open_page
      #bad data
      visit sw_project_customer_qnax.project_infos_path()      
      click_link 'Edit'
      select('', from: 'project_info_project_id')
      click_button 'Save'
      #save_and_open_page
      #
      visit sw_project_customer_qnax.project_infos_path(:customer_id => @cust.id, :project_id => @projj1.id)
      #save_and_open_page
      expect(page).to have_content('Project Infos')
      click_link 'New Project Info'
      #save_and_open_page
      select('a new name', :from => 'project_info_project_id')      
      #select('proj status', from: 'project_status_id')
      click_button 'Save'
      #save_and_open_page
      #bad data
      visit sw_project_customer_qnax.project_infos_path(customer_id: @cust.id, project_id: @projj.id)
      click_link 'New Project Info'
      select('', :from => 'project_info_project_id')
      fill_in :project_info_goal_to_achieve, :with => 'my new goal!'
      click_button 'Save'
      #save_and_open_page
      visit sw_project_customer_qnax.project_infos_path
      expect(page).not_to have_content('my new goal!')
      #
      visit sw_project_customer_qnax.project_infos_path
      click_link qp.id.to_s
      expect(page).to have_content('Project Info')
      #save_and_open_page
      click_link 'New Log'
      #save_and_open_page
      expect(page).to have_content('Log')
      #save_and_open_page
      
    end
    
    it "works for biz form" do
      qp = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, project_id: @projj.id)
      qb = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :last_updated_by_id => @u.id, project_info_id: qp.id)
      visit sw_project_customer_qnax.biz_forms_path()
      expect(page).to have_content('Biz Forms')
      click_link qb.id.to_s
      expect(page).to have_content('Biz Form Info')
      #
      visit sw_project_customer_qnax.biz_forms_path()      
      click_link 'Edit'
      #save_and_open_page
      expect(page).to have_content('Update Biz Form')
      fill_in 'biz_form_name', with: 'a new name'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.biz_forms_path(project_info_id: qp.id)
      expect(page).to have_content('a new name')
      #bad edit
      visit sw_project_customer_qnax.biz_forms_path()
      click_link 'Edit'
      fill_in 'biz_form_name', with: ''
      fill_in 'biz_form_description', with: 'a bad edit'
      #
      visit sw_project_customer_qnax.biz_forms_path()
      expect(page).not_to have_content('a bad edit')
      
      visit sw_project_customer_qnax.biz_forms_path(project_info_id: qp.id)
      click_link 'New Biz Form'
      fill_in 'biz_form_name', with: 'create a new biz form'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.biz_forms_path
      expect(page).to have_content('create a new biz form')
      #bad create
      visit sw_project_customer_qnax.biz_forms_path(project_info_id: qp.id)
      click_link 'New Biz Form'
      fill_in 'biz_form_name', with: ''
      fill_in 'biz_form_description', with: 'a bad create'
      #
      visit sw_project_customer_qnax.biz_forms_path
      expect(page).not_to have_content('a bad create')
    end
    
    it "works for workflow" do
      qp = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, project_id: @projj.id)
      qb = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :last_updated_by_id => @u.id, project_info_id: qp.id)
      qw = FactoryGirl.create(:sw_project_customer_qnax_workflow, :last_updated_by_id => @u.id, project_info_id: qp.id, name: 'a new act', biz_form_id: qb.id)
      visit sw_project_customer_qnax.workflows_path()
      #save_and_open_page
      expect(page).to have_content('Workflows')
      click_link qw.id.to_s
      expect(page).to have_content('Workflow Info')
      click_link 'New Log'
      #save_and_open_page
      expect(page).to have_content('Log')
      #
      visit sw_project_customer_qnax.workflows_path()      
      click_link 'Edit'
      #save_and_open_page
      expect(page).to have_content('Update Workflow')
      fill_in 'workflow_name', with: 'a new name'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.workflows_path(project_info_id: qp.id)
      expect(page).to have_content('a new name')
      #bad edit
      visit sw_project_customer_qnax.workflows_path()
      click_link 'Edit'
      fill_in 'workflow_name', with: ''
      fill_in 'workflow_brief_note', with: 'a bad edit'
      #
      visit sw_project_customer_qnax.workflows_path()
      expect(page).not_to have_content('a bad edit')
      
      visit sw_project_customer_qnax.workflows_path(project_info_id: qp.id)
      click_link 'New Workflow'
      select('MyString', from: 'workflow_biz_form_id')
      fill_in 'workflow_name', with: 'create a new workflow'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.workflows_path
      expect(page).to have_content('create a new workflow')
      #bad create
      visit sw_project_customer_qnax.workflows_path(project_info_id: qp.id)
      click_link 'New Workflow'
      select('', from: 'workflow_biz_form_id')
      fill_in 'workflow_name', with: ''
      fill_in 'workflow_brief_note', with: 'a bad create'
      #
      visit sw_project_customer_qnax.workflows_path
      expect(page).not_to have_content('a bad create')
    end
    
    it "works for user roles" do
      qp = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, project_id: @projj.id)
      qu = FactoryGirl.create(:sw_project_customer_qnax_user_role, :last_updated_by_id => @u.id, project_info_id: qp.id)
      visit sw_project_customer_qnax.user_roles_path()
      expect(page).to have_content('User Roles')
      click_link qu.id.to_s
      expect(page).to have_content('User Role Info')
      #
      visit sw_project_customer_qnax.user_roles_path()      
      click_link 'Edit'
      #save_and_open_page
      expect(page).to have_content('Update User Role')
      fill_in 'user_role_name', with: 'a new name'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.user_roles_path(project_info_id: qp.id)
      expect(page).to have_content('a new name')
      #bad edit
      visit sw_project_customer_qnax.user_roles_path()
      click_link 'Edit'
      fill_in 'user_role_name', with: ''
      fill_in 'user_role_for_department', with: 'a bad edit'
      #
      visit sw_project_customer_qnax.user_roles_path()
      expect(page).not_to have_content('a bad edit')
      
      visit sw_project_customer_qnax.user_roles_path(project_info_id: qp.id)
      click_link 'New Role'
      fill_in 'user_role_name', with: 'create a new user role'
      fill_in 'user_role_for_department', with: 'a good create'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.user_roles_path
      expect(page).to have_content('create a new user role')
      #bad create
      visit sw_project_customer_qnax.user_roles_path(project_info_id: qp.id)
      click_link 'New Role'
      fill_in 'user_role_name', with: ''
      fill_in 'user_role_for_department', with: 'a bad create'
      #
      visit sw_project_customer_qnax.user_roles_path
      expect(page).not_to have_content('a bad create')
    end
    
    it "works for role access right" do
      qp = FactoryGirl.create(:sw_project_customer_qnax_project_info, :last_updated_by_id => @u.id, project_id: @projj.id)
      qb = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :last_updated_by_id => @u.id, project_info_id: qp.id)
      qu = FactoryGirl.create(:sw_project_customer_qnax_user_role, :last_updated_by_id => @u.id, project_info_id: qp.id)
      qr = FactoryGirl.create(:sw_project_customer_qnax_role_access_right, :last_updated_by_id => @u.id, project_info_id: qp.id, action: 'a new act', user_role_id: qu.id, biz_form_id: qb.id)
      visit sw_project_customer_qnax.role_access_rights_path()
      expect(page).to have_content('Role Access Rights')
      click_link qb.id.to_s
      expect(page).to have_content('Role Access Right Info')
      #
      visit sw_project_customer_qnax.role_access_rights_path()      
      click_link 'Edit'
      #save_and_open_page
      expect(page).to have_content('Update Role Access Right')
      fill_in 'role_access_right_action', with: 'a new name'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.role_access_rights_path(project_info_id: qp.id)
      expect(page).to have_content('a new name')
      #bad edit
      visit sw_project_customer_qnax.role_access_rights_path()
      click_link 'Edit'
      fill_in 'role_access_right_action', with: ''
      fill_in 'role_access_right_brief_note', with: 'a bad edit'
      #
      visit sw_project_customer_qnax.role_access_rights_path()
      expect(page).not_to have_content('a bad edit')
      
      visit sw_project_customer_qnax.role_access_rights_path(project_info_id: qp.id)
      #save_and_open_page
      click_link 'New Access Right'
      save_and_open_page
      select('MyString', from: 'role_access_right_user_role_id')
      select('MyString', from: 'role_access_right_biz_form_id') 
      fill_in 'role_access_right_action', with: 'create a new access right'
      click_button 'Save'
      #
      visit sw_project_customer_qnax.role_access_rights_path
      expect(page).to have_content('create a new access right')
      #bad create
      visit sw_project_customer_qnax.role_access_rights_path(project_info_id: qp.id)
      click_link 'New Access Right'
      select('', from: 'role_access_right_user_role_id')
      select('MyString', from: 'role_access_right_biz_form_id')
      fill_in 'role_access_right_action', with: ''
      fill_in 'role_access_right_brief_note', with: 'a bad create'
      #
      visit sw_project_customer_qnax.role_access_rights_path
      expect(page).not_to have_content('a bad create')
    end
  end
end
