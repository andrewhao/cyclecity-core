class AddActivityTypes < ActiveRecord::Migration
  def up
    Activity.create(key: "unknown")
    Activity.create(key: "run")
    Activity.create(key: "cycle")
    Activity.create(key: "hike")
  end

  def down
    Activity.delete_all
  end
end
