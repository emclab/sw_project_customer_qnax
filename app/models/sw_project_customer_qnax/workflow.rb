module SwProjectCustomerQnax
  class Workflow < ActiveRecord::Base
    attr_accessor :last_updated_by_name
=begin
    attr_accessible :brief_note, :last_updated_by_id, :project_info_id, :name, :biz_form_id, :workflow_steps_attributes, 
                    :as => :role_new
    attr_accessible :brief_note, :last_updated_by_id, :project_info_id, :name, :biz_form_id, :workflow_steps_attributes,
                    :as => :role_update
=end    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :project_info, :class_name => 'SwProjectCustomerQnax::ProjectInfo'
    belongs_to :biz_form, :class_name => 'SwProjectCustomerQnax::BizForm'
    has_many :workflow_steps, :class_name => 'SwProjectCustomerQnax::WorkflowStep'
    accepts_nested_attributes_for :workflow_steps, :allow_destroy => true
    
    validates :name, :presence => true  
    validates :name, :uniqueness => {:scope => [:project_info_id, :biz_form_id], :case_sensitive => false, :message => I18n.t('Duplicate Name!')}
    validates :project_info_id, :biz_form_id, :presence => true, :numericality => {:only_integer => true, :greater_than => 0}  
    validate :dynamic_validate 
    
    def dynamic_validate
      wf = Authentify::AuthentifyUtility.find_config_const('dynamic_validate_workflow', 'sw_project_customer_qnax')
      eval(wf) if wf.present?
    end       
  end
end
