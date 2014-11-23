module SwProjectCustomerQnax
  class UserRole < ActiveRecord::Base
    attr_accessor :project_info_name
    attr_accessible :for_department, :brief_note, :last_updated_by_id, :name, :project_info_id,
                    :as => :role_new
    attr_accessible :for_department, :brief_note, :last_updated_by_id, :name, 
                    :as => :role_update
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :project_info, :class_name => 'SwProjectCustomerQnax::ProjectInfo'
    has_many :role_access_rights, :class_name => 'SwProjectCustomerQnax::RoleAccessRight'
    has_many :workflow_steps, :class_name => 'SwProjectCustomerQnax::WorkflowStep'
    
    validates :project_info_id, :presence => true,
                                :numericality => {:only_integer => true, :greater_than => 0}
    validates :name, :for_department, :presence => true   
    validates :name, :uniqueness => {:scope => :project_info_id, :case_sensitive => false, :message => 'Duplicate Name!'} 
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_user_role', 'sw_project_customer_qnax')
      eval(wf) if wf.present?
    end        
  end
end
