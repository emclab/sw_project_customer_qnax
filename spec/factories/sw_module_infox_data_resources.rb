# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sw_module_infox_data_resource, :class => 'SwModuleInfox::DataResource' do
    module_info_id 1
    name "MyString"
    name_non_tech "MyString"
    brief_note "MyString"
  end
end
