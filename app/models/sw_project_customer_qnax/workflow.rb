module SwProjectCustomerQnax
  class Workflow < ActiveRecord::Base
    attr_accessible :brief_note, :last_updated_by_id, :project_info_id, :wf_name, :with_form
  end
end
