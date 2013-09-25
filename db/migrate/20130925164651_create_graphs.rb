class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :setting

      t.timestamps
    end
  end
end
