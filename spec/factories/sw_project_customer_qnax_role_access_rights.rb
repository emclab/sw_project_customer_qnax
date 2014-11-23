# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_project_customer_qnax_role_access_right, :class => 'SwProjectCustomerQnax::RoleAccessRight' do
    project_info_id 1
    user_role_id 1
    action "MyString"
    biz_form_id 1
    brief_note "MyString"
    last_updated_by_id 1
  end
end
