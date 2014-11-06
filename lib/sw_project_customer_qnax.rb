require "sw_project_customer_qnax/engine"

module SwProjectCustomerQnax
  mattr_accessor :customer_class, :project_class
  
  def self.customer_class
    @@customer_class.constantize
  end
  
  def self.project_class
    @@project_class.constantize
  end
end
