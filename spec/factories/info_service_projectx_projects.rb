# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :info_service_projectx_project, :class => 'InfoServiceProjectx::Project' do
    customer_id 1
    service_num 1
    name "MyString project"
    project_desp "MyText desp"
    develop_start_date "2014-02-14"
    develop_finish_date '2014-04-23'
    status_id 1
    last_updated_by_id 1
    cancelled false
    decommissioned false
    decommissioned_date "2014-02-14"
    decommission_reason "MyText reason"
    cancelled_date '2014-02-13'
    cancell_reason 'why cancell?'
    initial_online_date "2014-02-14"
    fully_online_date "2014-02-14"
  end
end
