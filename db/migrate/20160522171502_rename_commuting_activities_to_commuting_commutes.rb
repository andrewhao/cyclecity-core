class RenameCommutingActivitiesToCommutingCommutes < ActiveRecord::Migration
  def change
    rename_table 'commuting_activities', 'commuting_commutes'
  end
end
