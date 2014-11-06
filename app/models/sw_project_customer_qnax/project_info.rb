module SwProjectCustomerQnax
  class ProjectInfo < ActiveRecord::Base
    attr_accessor :project_name, :last_updated_by_name, :submitted_by_name, :customer_name
    attr_accessible :key_biz_form, :current_it_status, :customer_id, :goal, :has_broadband, :last_updated_by_id, :main_biz, :name, :number_of_desktop, 
                    :number_of_laptop, :number_of_tablet, :number_of_user, :project_id, :submitted_by_id, :urgent_to_solve, :use_smartphone, :im_in_use,
                    :broswer_in_use, :multi_location, :data_center, :os_in_use, :desp_of_location, :desp_of_dept, :sw_in_use, :desp_of_data_center,
                    :project_name, :customer_name, 
                    :as => :role_new
    attr_accessible :key_biz_form, :current_it_status, :customer_id, :goal, :has_broadband, :main_biz, :name, :number_of_desktop, 
                    :number_of_laptop, :number_of_tablet, :number_of_user, :project_id, :submitted_by_id, :urgent_to_solve, :use_smartphone, :im_in_use,
                    :broswer_in_use, :multi_location, :data_center, :os_in_use, :desp_of_location, :desp_of_dept, :sw_in_use, :desp_of_data_center,
                    :project_name, :last_updated_by_name, :submitted_by_name, :customer_name,
                    :as => :role_update
    attr_accessor :customer_id_s, :start_date_s, :end_date_s, :name_s, :submitted_by_id_s, :key_biz_form_s, :multi_location_s, :use_smartphone_s, :data_center_s,
                  :multi_location_s
    attr_accessible :customer_id_s, :start_date_s, :end_date_s, :name_s, :submitted_by_id_s, :key_biz_form_s, :multi_location_s, :use_smartphone_s, :data_center_s,
                    :multi_location_s,
                    :as => :role_search_stats
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :submitted_by, :class_name => 'Authentify::User'
    belongs_to :customer, :class_name => SwProjectCustomerQnax.customer_class.to_s
    belongs_to :project, :class_name => SwProjectCustomerQnax.project_class.to_s
    
    validates :project_id, :customer_id, :submitted_by_id, :presence => true,
                                         :numericality => {:only_integer => true, :greater_than => 0}
    validates :name, :presence => true
    validates :name, :uniqueness => {:scope => :customer_id, :case_sensitive => false, :message => 'Duplidate Name!'}
    validates :number_of_user, :numericality => {:only_integer => true, :greater_than => 0}, :if => 'number_of_user.present?'    
    validates :number_of_desktop, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :if => 'number_of_desktop.present?'    
    validates :number_of_laptop, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :if => 'number_of_laptop.present?'    
    validates :number_of_tablet, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :if => 'number_of_tablet.present?'    
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_project_info', 'sw_project_customer_qnaxx')
      eval(wf) if wf.present?
    end        
  end
end
