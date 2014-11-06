class CreateSwProjectCustomerQnaxProjectInfos < ActiveRecord::Migration
  def change
    create_table :sw_project_customer_qnax_project_infos do |t|
      t.integer :customer_id
      t.integer :project_id
      t.integer :last_updated_by_id
      t.integer :submitted_by_id
      t.string :name
      t.text :goal
      t.text :main_biz
      t.string :key_biz_form
      t.integer :number_of_user
      t.string :urgent_to_solve
      t.text :current_it_status
      t.boolean :has_broadband
      t.integer :number_of_desktop
      t.integer :number_of_laptop
      t.integer :number_of_tablet
      t.boolean :use_smartphone
      t.string :im_in_use  #instant message
      t.string :os_in_use
      t.string :broswer_in_use
      t.boolean :has_data_center
      t.text :desp_of_data_center
      t.text :sw_in_use  #software in use
      t.boolean :multi_location, :default => false
      t.text :desp_of_location
      t.text :desp_of_dept

      t.timestamps
    end
    
    add_index :sw_project_customer_qnax_project_infos, :customer_id
    add_index :sw_project_customer_qnax_project_infos, :project_id
    add_index :sw_project_customer_qnax_project_infos, :submitted_by_id
    add_index :sw_project_customer_qnax_project_infos, :name
  end
end
