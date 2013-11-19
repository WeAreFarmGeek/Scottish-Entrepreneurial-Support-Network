class CreateSearchTypes < ActiveRecord::Migration
  def change
    create_table :search_types do |t|
      t.string :name
      t.timestamps
    end
    add_index :search_types, :name
  end
end
