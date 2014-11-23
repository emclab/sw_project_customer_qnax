module SwProjectCustomerQnax
  class ProjectInfo < ActiveRecord::Base
    attr_accessor :project_name, :last_updated_by_name, :submitted_by_name, :customer_name
    attr_accessible :key_biz_form, :customer_id, :goal_to_achieve, :about_broadband, :last_updated_by_id, :main_biz,  
                    :number_of_user, :project_id, :submitted_by_id, :issue_to_solve, :im_in_use, :about_hardware, :about_software, :about_network,
                    :broswer_in_use, :about_office_location, :about_data_center, :os_in_use, :about_department, :locked,
                    :project_name, :customer_name, 
                    :as => :role_new
    attr_accessible :key_biz_form,  :customer_id, :goal_to_achieve, :about_broadband, :main_biz, 
                    :number_of_user, :project_id, :submitted_by_id, :issue_to_solve, :im_in_use, :about_hardware, :about_software, :about_network,
                    :broswer_in_use, :about_data_center, :os_in_use, :about_office_location, :about_department,  :locked,
                    :project_name, :last_updated_by_name, :submited_by_name, :customer_name,
                    :as => :role_update
    attr_accessor :customer_id_s, :start_date_s, :end_date_s, :project_id_s, :submitted_by_id_s, :key_biz_form_s, :im_in_use_s, :use_smartphone_s, :data_center_s,
                  :lock_s
    attr_accessible :customer_id_s, :start_date_s, :end_date_s, :project_id_s, :submitted_by_id_s, :key_biz_form_s, :im_in_use_s, :use_smartphone_s, :data_center_s,
                    :locked_s,
                    :as => :role_search_stats
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :submitted_by, :class_name => 'Authentify::User'
    belongs_to :customer, :class_name => SwProjectCustomerQnax.customer_class.to_s
    belongs_to :project, :class_name => SwProjectCustomerQnax.project_class.to_s
    has_many :user_roles, :class_name => 'SwProjectCustomerQnax::UserRole'
    has_many :role_access_rights, :class_name => 'SwProjectCustomerQnax::RoleAccessRight'
    has_many :workflows, :class_name => 'SwProjectCustomerQnax::Workflow'
    has_many :workflow_steps, :through => :workflows
    
    validates :project_id, :customer_id, :presence => true,
                                         :numericality => {:only_integer => true, :greater_than => 0}
    validates :project_id, :uniqueness => {:scope => :customer_id, :case_sensitive => false, :message => I18n.t('Duplicate Project!')}
    validates :number_of_user, :numericality => {:only_integer => true, :greater_than => 0}, :if => 'number_of_user.present?'    
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_project_info', 'sw_project_customer_qnax')
      eval(wf) if wf.present?
    end        
  end
end
