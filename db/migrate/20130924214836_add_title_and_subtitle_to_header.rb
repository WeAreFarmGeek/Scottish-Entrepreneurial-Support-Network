class AddTitleAndSubtitleToHeader < ActiveRecord::Migration
  def change
    add_column :headers, :title, :string
    add_column :headers, :subtitle, :string
  end
end
