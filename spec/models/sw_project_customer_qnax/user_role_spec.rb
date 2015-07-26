require 'rails_helper'

module SwProjectCustomerQnax
  RSpec.describe UserRole, type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:sw_project_customer_qnax_user_role)
      expect(c).to be_valid
    end
    
    it "should reject 0 project_info_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_user_role, :project_info_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should not take nil name" do
      c = FactoryGirl.build(:sw_project_customer_qnax_user_role, :name => nil)
      expect(c).not_to be_valid
    end 
    
    it "should not take nil for_department" do
      c = FactoryGirl.build(:sw_project_customer_qnax_user_role, :for_department => nil)
      expect(c).not_to be_valid
    end
    
    it "should not take duplidate name" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_user_role, :name => 'nil')
      c = FactoryGirl.build(:sw_project_customer_qnax_user_role, :name => 'nIl')
      expect(c).not_to be_valid
    end
    
    it "should take duplidate name for different project_info_id" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_user_role, :name => 'nil')
      c = FactoryGirl.build(:sw_project_customer_qnax_user_role, :name => 'nIl', :project_info_id => c1.project_info_id + 1)
      expect(c).to be_valid
    end 
    
  end
end
