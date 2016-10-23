class AddAttachmentPictureToTracks < ActiveRecord::Migration
  def self.up
    change_table :tracks do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :tracks, :picture
  end
end