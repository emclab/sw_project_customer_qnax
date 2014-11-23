class CreateSwProjectCustomerQnaxRoleAccessRights < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_role_access_rights do |t|
      t.integer :project_info_id
      t.integer :user_role_id
      t.string :action
      t.integer :biz_form_id
      t.string :brief_note
      t.integer :last_updated_by_id
      t.boolean :processed, :default => false  #processed by developer

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_role_access_rights, :project_info_id, :name => :index_customer_qnax_project_info_id
    add_index :sw_project_customer_qnax_role_access_rights, :user_role_id, :name => :index_customer_qnax_role_id
    add_index :sw_project_customer_qnax_role_access_rights, :action
    add_index :sw_project_customer_qnax_role_access_rights, :biz_form_id, :name => :index_customer_qnax_biz_form_id
    add_index :sw_project_customer_qnax_role_access_rights, :processed
  end
end
