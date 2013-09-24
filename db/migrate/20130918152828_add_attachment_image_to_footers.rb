class AddAttachmentImageToFooters < ActiveRecord::Migration
  def self.up
    change_table :footers do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :footers, :image
  end
end
