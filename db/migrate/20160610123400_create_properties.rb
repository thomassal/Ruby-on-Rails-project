class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :varable
      t.string :value

      t.timestamps null: false
    end
  end
end
