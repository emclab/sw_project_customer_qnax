# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_project_customer_qnax_workflow_step, :class => 'SwProjectCustomerQnax::WorkflowStep' do
    workflow_id 1
    user_role_id 1
    action "MyString"
    brief_note "MyText"
    index 1
  end
end
