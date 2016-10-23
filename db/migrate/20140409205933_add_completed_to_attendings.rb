class AddCompletedToAttendings < ActiveRecord::Migration
  def change
  	add_column :attendings, :completed, :boolean
  end
end
