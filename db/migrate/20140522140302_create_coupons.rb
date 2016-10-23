class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.belongs_to :track, index: true
      t.integer :percent_discount
      t.boolean :is_active
      t.timestamps
    end
  end
end
