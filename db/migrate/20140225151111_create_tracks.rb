class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :intro_video
      t.belongs_to :user

      t.timestamps
    end
  end
end
