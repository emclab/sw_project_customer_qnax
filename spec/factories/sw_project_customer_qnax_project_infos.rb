# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_project_customer_qnax_project_info, :class => 'SwProjectCustomerQnax::ProjectInfo' do
    customer_id 1
    project_id 1
    #last_updated_by_id 1
    submitted_by_id 1
    name "MyString"
    goal "MyText"
    main_biz "MyText"
    key_biz_form "MyText"
    number_of_user 1
    urgent_to_solve "MyString"
    current_it_status "MyText"
    has_broadband false
    number_of_desktop 1
    number_of_laptop 1
    number_of_tablet 1
    use_smartphone false
    has_data_center false
  end
end
