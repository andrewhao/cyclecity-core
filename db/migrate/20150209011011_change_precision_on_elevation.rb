class ChangePrecisionOnElevation < ActiveRecord::Migration
  def change
    change_column :track_points, :elevation, :decimal
  end
end
