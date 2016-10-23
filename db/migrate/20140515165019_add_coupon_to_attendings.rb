class AddCouponToAttendings < ActiveRecord::Migration
   def change
    add_column :attendings, :coupon, :string
  end
end