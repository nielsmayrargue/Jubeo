class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :title
      t.text :description
      t.string :video
      t.integer :order
      t.belongs_to :track, index: true

      t.timestamps
    end
  end
end
