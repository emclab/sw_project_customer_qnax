# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_module_infox_module_action, :class => 'SwModuleInfox::ModuleAction' do
    module_info_id 1
    name "MyString"
    name_non_tech "MyString"
    data_resource_id 1
    desp "MyString"
    desp_non_tech "MyString"
    present_to_customer true
    #last_updated_by_id 1
  end
end
