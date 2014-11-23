require 'spec_helper'

module SwProjectCustomerQnax
  describe WorkflowStep do
    it "should be OK" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step)
      c.should be_valid
    end
    
    it "should reject 0 user_role_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step, :user_role_id => 0)
      c.should_not be_valid
    end
    
    it "should reject nil index" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step, :ranking_index => nil)
      c.should_not be_valid
    end
    
    it "should not take nil action" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step, :action => nil)
      c.should_not be_valid
    end 
  end
end
