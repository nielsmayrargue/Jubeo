class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :attending, index: true
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
