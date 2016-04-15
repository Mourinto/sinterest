class CreatePlaylistsTracksJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :playlists_tracks do |t|
      t.integer :playlist_id
      t.integer :track_id
      t.timestamps
    end
  end
end
