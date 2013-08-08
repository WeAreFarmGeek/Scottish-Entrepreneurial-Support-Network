class CreateOrganisation < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string  :name
      t.text    :blurb
      t.integer :parent
    end
    add_attachment :organisations, :logo
  end
end
