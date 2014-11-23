# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_project_customer_qnax_project_info, :class => 'SwProjectCustomerQnax::ProjectInfo' do
    customer_id 1
    project_id 1
    #last_updated_by_id 1
    submitted_by_id 1
    #name "MyString"
    goal_to_achieve "MyText"
    main_biz "MyText"
    key_biz_form "MyText"
    number_of_user 1
    issue_to_solve "MyString"
    about_broadband '3M broadband'
    about_hardware 'hardware'
    about_software 'software'
    about_network 'network'
    about_data_center 'false'
    about_department 'dept1, 2'
    about_office_location 'about location'
  end
end
