class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :search_type_id
      t.string :search
      t.timestamps
    end
    add_index :searches, :search_type_id
  end
end
