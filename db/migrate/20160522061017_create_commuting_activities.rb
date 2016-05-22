class CreateCommutingActivities < ActiveRecord::Migration
  def change
    create_table :commuting_activities do |t|
      t.string :name
      t.datetime :started_at
      t.json :raw

      t.timestamps
    end
  end
end
