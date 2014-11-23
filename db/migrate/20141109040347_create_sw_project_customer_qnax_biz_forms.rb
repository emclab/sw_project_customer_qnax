class CreateSwProjectCustomerQnaxBizForms < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_biz_forms do |t|
      t.integer :project_info_id
      t.string :name
      t.text :description
      t.integer :last_updated_by_id
      t.boolean :key_form, :default => false

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_biz_forms, :project_info_id
    add_index :sw_project_customer_qnax_biz_forms, :name
    add_index :sw_project_customer_qnax_biz_forms, :key_form
  end
end
