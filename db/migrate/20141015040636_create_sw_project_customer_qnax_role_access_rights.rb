class CreateSwProjectCustomerQnaxRoleAccessRights < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_role_access_rights do |t|
      t.integer :user_role_id
      t.string :action
      t.string :resource
      t.string :brief_note
      t.integer :last_updated_by_id
      t.boolean :processed, :default => false

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_role_access_rights, :user_role_id
    add_index :sw_project_customer_qnax_role_access_rights, :action
    add_index :sw_project_customer_qnax_role_access_rights, :resource
    add_index :sw_project_customer_qnax_role_access_rights, :processed
  end
end
