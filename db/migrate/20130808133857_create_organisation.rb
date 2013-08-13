class CreateOrganisation < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string  :name
      t.text    :blurb
      t.integer :child_id
    end
    add_attachment :organisations, :logo
  end
end
