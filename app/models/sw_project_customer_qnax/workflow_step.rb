module SwProjectCustomerQnax
  class WorkflowStep < ActiveRecord::Base
    attr_accessible :action, :brief_note, :ranking_index, :user_role_id, :workflow_id,
                    :as => :role_new
    attr_accessible :action, :brief_note, :ranking_index, :user_role_id, :workflow_id,
                    :as => :role_new 
                     
    belongs_to :user_role, :class_name => 'SwProjectCustomerQnax::UserRole'
    belongs_to :workflow, :class_name => 'SwProjectCustomerQnax::Workflow'
    
    validates :action, :presence => true  
    validates :user_role_id, :ranking_index, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}  
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_workflow_step', 'sw_project_customer_qnax')
      eval(wf) if wf.present?
    end                    
  end
end
