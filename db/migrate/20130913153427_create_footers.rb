class CreateFooters < ActiveRecord::Migration
  def change
    create_table :footers do |t|
      t.string :image

      t.timestamps
    end
  end
end
