require 'rails_helper'

module SwProjectCustomerQnax
  RSpec.describe WorkflowStep , type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step)
      expect(c).to be_valid
    end
    
    it "should reject 0 user_role_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step, :user_role_id => 0)
      expect(c).not_to be_valid
    end
    
    it "should reject nil index" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step, :ranking_index => nil)
      expect(c).not_to be_valid
    end
    
    it "should not take nil action" do
      c = FactoryGirl.build(:sw_project_customer_qnax_workflow_step, :action => nil)
      expect(c).not_to be_valid
    end 
  end
end
