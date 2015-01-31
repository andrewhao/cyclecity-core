class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.multi_line_string :path, srid: 3785
      t.string :title
      t.text :description
      t.references :activity
      t.timestamps
    end
  end
end
