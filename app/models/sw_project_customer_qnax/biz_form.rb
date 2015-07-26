module SwProjectCustomerQnax
  class BizForm < ActiveRecord::Base
    attr_accessor :project_info_name
=begin
    attr_accessible :description, :key_form, :last_udpated_by_id, :name, :project_info_id,
                    :as => :role_new
    attr_accessible :description, :key_form, :name,
                    :as => :role_update
    attr_accessor :name_s, :description_s, :key_form_s, :project_info_id_s
    attr_accessible :name_s, :description_s, :key_form_s, :project_info_id_s,
                    :as => :role_search_stats
=end    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :project_info, :class_name => 'SwProjectCustomerQnax::ProjectInfo'
    
    validates :project_info_id, :presence => true,
                                :numericality => {:only_integer => true, :greater_than => 0}
    validates :name, :presence => true   
    validates :name, :uniqueness => {:scope => :project_info_id, :case_sensitive => false, :message => I18n.t('Duplicate Name!')} 
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_biz_form', 'sw_project_customer_qnax')
      eval(wf) if wf.present?
    end        
  end
end
