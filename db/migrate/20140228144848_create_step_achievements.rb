class CreateStepAchievements < ActiveRecord::Migration
  def change
    create_table :step_achievements do |t|
      t.belongs_to :attending, index: true
      t.belongs_to :step, index: true

      t.timestamps
    end
  end
end
