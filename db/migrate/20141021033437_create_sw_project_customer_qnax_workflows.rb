class CreateSwProjectCustomerQnaxWorkflows < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_workflows do |t|
      t.integer :project_info_id
      t.string :wf_name
      t.string :with_form
      t.text :brief_note
      t.integer :last_updated_by_id

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_workflows, :project_info_id
    add_index :sw_project_customer_qnax_workflows, :wf_name
    add_index :sw_project_customer_qnax_workflows, :with_form
  end
end
