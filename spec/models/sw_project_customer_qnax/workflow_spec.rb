require 'spec_helper'

module SwProjectCustomerQnax
  describe Workflow do
    it "should be OK" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow)
      c.should be_valid
    end
    
    it "should reject nil project_info_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow, :project_info_id => 0)
      c.should_not be_valid
    end
    
    it "should reject nil workflow_name" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow, :name => nil)
      c.should_not be_valid
    end
    
    it "should not take nil for_form id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow, :biz_form_id => 0)
      c.should_not be_valid
    end 
  end
end
