class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.string :ip_address
      t.string :image
      t.datetime :launch_time
      t.string :status

      t.timestamps null: false
    end
  end
end
