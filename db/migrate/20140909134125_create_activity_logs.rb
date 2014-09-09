class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.string :activity_instance_id
      t.string :activity_object_id
      t.decimal :contact_id, precision: 32, scale: 0
      t.string :contact_key
			
      t.timestamps
    end
  end
end
