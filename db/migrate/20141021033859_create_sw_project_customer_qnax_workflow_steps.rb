class CreateSwProjectCustomerQnaxWorkflowSteps < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_workflow_steps do |t|
      t.integer :workflow_id
      t.integer :user_role_id
      t.string :action
      t.text :brief_note
      t.integer :ranking_index  #index is a ruby keywork

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_workflow_steps, :workflow_id
    add_index :sw_project_customer_qnax_workflow_steps, :user_role_id
    add_index :sw_project_customer_qnax_workflow_steps, :action
    add_index :sw_project_customer_qnax_workflow_steps, :ranking_index
  end
end
