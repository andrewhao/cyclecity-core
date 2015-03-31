class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :key, null: false
      t.timestamps null: false
    end
  end
end
