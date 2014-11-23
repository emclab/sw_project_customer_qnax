require 'spec_helper'

module SwProjectCustomerQnax
  describe ProjectInfo do
    it "should be OK" do
      c = FactoryGirl.build(:sw_project_customer_qnax_project_info)
      c.should be_valid
    end
    
    it "should reject nil project_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_project_info, :project_id => 0)
      c.should_not be_valid
    end
    
    it "should reject 0 users" do
      c = FactoryGirl.build(:sw_project_customer_qnax_project_info, :number_of_user => 0)
      c.should_not be_valid
    end
    
    it "should reject duplicate project_id" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_project_info)
      c = FactoryGirl.build(:sw_project_customer_qnax_project_info)
      c.should_not be_valid
    end
    
  end
end
