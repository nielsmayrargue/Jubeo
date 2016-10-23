class AddAudioToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :audio, :string
  end
end
