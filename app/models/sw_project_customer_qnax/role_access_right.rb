module SwProjectCustomerQnax
  class RoleAccessRight < ActiveRecord::Base
    attr_accessor :user_role_name, :biz_form_name
=begin
    attr_accessible :action, :brief_note, :last_updated_by_id, :biz_form_id, :user_role_id, :processed, :project_info_id,
                    :user_role_name,
                    :as => :role_new
    attr_accessible :action, :brief_note, :last_updated_by_id, :biz_form_id, :processed, :user_role_id,
                    :user_role_name, :biz_form_name,
                    :as => :role_update
    
    attr_accessor :start_date_s, :end_date_s, :action_s, :biz_form_id_s, :user_role_id_s, :processed_s, :customer_id_s, :project_info_id_s
    attr_accessible :start_date_s, :end_date_s, :action_s, :biz_form_id_s, :user_role_id_s, :processed_s, :customer_id_s, :project_info_id_s,
                    :as => :role_search_stats
=end    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :user_role, :class_name => 'SwProjectCustomerQnax::UserRole'
    belongs_to :project_info, :class_name => 'SwProjectCustomerQnax::ProjectInfo'
    belongs_to :biz_form, :class_name => 'SwProjectCustomerQnax::BizForm'
    
    validates :user_role_id, :biz_form_id, :presence => true,
                             :numericality => {:only_integer => true, :greater_than => 0}
    validates :action, :presence => true 
    validates :action, :uniqueness => {:scope => [:biz_form_id, :user_role_id], :case_sensitive => false, :message => I18n.t('Duplicate Action!')}   
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_role_access_right', 'sw_project_customer_qnax')
      eval(wf) if wf.present?
    end        
  end
end
