class CreateHeaders < ActiveRecord::Migration
  def change
    create_table :headers do |t|
      t.timestamps
    end
    add_attachment :headers, :image
  end
end
