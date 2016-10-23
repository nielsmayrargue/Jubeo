class AddStatusToTracks < ActiveRecord::Migration
  def change
  	add_column :tracks, :status, :string
  end
end
