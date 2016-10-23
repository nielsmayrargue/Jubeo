class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :tracks, :tags do |t|
      t.index [:track_id, :tag_id]
      t.index [:tag_id, :track_id]
    end
  end
end
