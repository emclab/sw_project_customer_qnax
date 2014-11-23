class CreateSwProjectCustomerQnaxProjectInfos < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_project_infos do |t|
      t.integer :customer_id
      t.integer :project_id
      t.integer :last_updated_by_id
      t.integer :submitted_by_id
      t.text :goal_to_achieve
      t.text :main_biz
      t.string :key_biz_form
      t.integer :number_of_user
      t.string :issue_to_solve
      t.text :about_broadband
      t.text :about_hardware
      t.text :about_software
      t.text :about_network
      t.text :about_data_center
      t.text :about_office_location
      t.text :about_department
      t.string :im_in_use  #instant message
      t.string :os_in_use
      t.string :broswer_in_use
      t.boolean :locked, :default => false #if lock, then customer can not update project info

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_project_infos, :customer_id
    add_index :sw_project_customer_qnax_project_infos, :project_id
    add_index :sw_project_customer_qnax_project_infos, :submitted_by_id
    add_index :sw_project_customer_qnax_project_infos, :locked
  end
end
