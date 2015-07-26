require 'rails_helper'

module SwProjectCustomerQnax
  RSpec.describe RoleAccessRight , type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:sw_project_customer_qnax_role_access_right)
      expect(c).to be_valid
    end
    
    it "should reject 0 user_role_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_role_access_right, :user_role_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject 0 biz_form_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_role_access_right, :biz_form_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should not take nil action" do
      c = FactoryGirl.build(:sw_project_customer_qnax_role_access_right, :action => nil)
      expect(c).not_to be_valid
    end 
    
    it "should not take duplidate action" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_role_access_right, :action => 'nil')
      c = FactoryGirl.build(:sw_project_customer_qnax_role_access_right, :action => 'nIl')
      expect(c).not_to be_valid
    end 
    
    it "should take duplidate action for different resource" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_role_access_right, :action => 'nil')
      c = FactoryGirl.build(:sw_project_customer_qnax_role_access_right, :action => 'nIl', :biz_form_id => 30)
      expect(c).to be_valid
    end
    
    it "should take duplidate action for same resource & different user_role" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_role_access_right, :action => 'nil')
      c = FactoryGirl.build(:sw_project_customer_qnax_role_access_right, :action => 'nIl', :user_role_id => c1.user_role_id + 1)
      expect(c).to be_valid
    end
  end
end
