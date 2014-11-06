class CreateSwProjectCustomerQnaxUserRoles < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_user_roles do |t|
      t.integer :project_info_id
      t.string :name
      t.text :brief_note
      t.integer :last_updated_by_id
      t.string :for_department

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_user_roles, :project_info_id
    add_index :sw_project_customer_qnax_user_roles, :name
  end
end
