module SwProjectCustomerQnax
  class WorkflowStep < ActiveRecord::Base
    attr_accessible :action, :brief_note, :index, :user_role_id, :workflow_id
  end
end
