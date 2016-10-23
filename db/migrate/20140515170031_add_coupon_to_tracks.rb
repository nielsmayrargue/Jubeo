class AddCouponToTracks < ActiveRecord::Migration
   def change
    add_column :tracks, :coupon, :string
  end
end