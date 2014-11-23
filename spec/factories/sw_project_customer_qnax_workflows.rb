# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_project_customer_qnax_workflow, :class => 'SwProjectCustomerQnax::Workflow' do
    project_info_id 1
    name "MyString"
    biz_form_id 1
    brief_note "MyText"
    #last_updated_by_id 1
  end
end
