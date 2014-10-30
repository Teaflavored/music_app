class EditTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :album_id, :integer
    change_column :tracks, :album_id, :integer, null: false
    add_column :tracks, :track_type, :string
    change_column :tracks, :track_type, :string, null: false
    add_column :tracks, :lyrics, :text
  end
end
