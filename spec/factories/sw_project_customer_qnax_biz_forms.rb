# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_project_customer_qnax_biz_form, :class => 'SwProjectCustomerQnax::BizForm' do
    project_info_id 1
    name "MyString"
    description "MyText"
    #last_udpated_by_id 1
    key_form false
  end
end
