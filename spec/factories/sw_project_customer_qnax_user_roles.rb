# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_project_customer_qnax_user_role, :class => 'SwProjectCustomerQnax::UserRole' do
    project_info_id 1
    name "MyString"
    brief_note "MyText"
    last_updated_by_id 1
    for_department "MyString"
  end
end
