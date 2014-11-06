module SwProjectCustomerQnax
  class RoleAccessRight < ActiveRecord::Base
    attr_accessor :user_role_name
    attr_accessible :action, :brief_note, :last_updated_by_id, :resource, :user_role_id, :processed,
                    :user_role_name,
                    :as => :role_new
    attr_accessible :action, :brief_note, :last_updated_by_id, :resource, :processed,
                    :user_role_name,
                    :as => :role_updated
    
    attr_accessor :start_date_s, :end_date_s, :action_s, :resource_s, :user_role_id_s, :processed_s, :customer_id_s, :project_id_s
    attr_accessible :start_date_s, :end_date_s, :action_s, :resource_s, :user_role_id_s, :processed_s, :customer_id_s, :project_id_s,
                    :as => :role_search_stats
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :user_role, :class_name => 'SwProjectCustomerQnax::UserRole'
    
    validates :user_role_id, :presence => true,
                             :numericality => {:only_integer => true, :greater_than => 0}
    validates :action, :resource, :presence => true 
    validates :action, :uniqueness => {:scope => [:resource, :user_role_id], :case_sensitive => false, :message => 'Duplicate Action!'}   
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_role_access_right', 'sw_project_customer_qnaxx')
      eval(wf) if wf.present?
    end        
  end
end
