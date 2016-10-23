class AddProofToTracks < ActiveRecord::Migration
  def change
  	add_column :tracks, :proof, :string
  end
end
