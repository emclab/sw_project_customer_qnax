require 'spec_helper'

module SwProjectCustomerQnax
  describe BizForm do
    it "should be OK" do
      c = FactoryGirl.build(:sw_project_customer_qnax_biz_form)
      c.should be_valid
    end
    
    it "should reject 0 project_info_id" do
      c = FactoryGirl.build(:sw_project_customer_qnax_biz_form, :project_info_id => 0)
      c.should_not be_valid
    end
    
    it "should not take nil name" do
      c = FactoryGirl.build(:sw_project_customer_qnax_biz_form, :name => nil)
      c.should_not be_valid
    end 
    
    it "should take nil description" do
      c = FactoryGirl.build(:sw_project_customer_qnax_biz_form, :description => nil)
      c.should be_valid
    end
    
    it "should not take duplidate name" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :name => 'nil')
      c = FactoryGirl.build(:sw_project_customer_qnax_biz_form, :name => 'nIl')
      c.should_not be_valid
    end
    
    it "should take duplidate name for different project_info_id" do
      c1 = FactoryGirl.create(:sw_project_customer_qnax_biz_form, :name => 'nil')
      c = FactoryGirl.build(:sw_project_customer_qnax_biz_form, :name => 'nIl', :project_info_id => c1.project_info_id + 1)
      c.should be_valid
    end 
  end
end
