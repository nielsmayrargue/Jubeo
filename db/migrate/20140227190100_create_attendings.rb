class CreateAttendings < ActiveRecord::Migration
  def change
    create_table :attendings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :track, index: true
      t.integer :transaction_cost
      t.boolean :is_paid

      t.timestamps
    end
  end
end
