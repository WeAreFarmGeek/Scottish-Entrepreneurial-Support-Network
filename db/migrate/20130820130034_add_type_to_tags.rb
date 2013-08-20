class AddTypeToTags < ActiveRecord::Migration
  def change
    add_column :tags, :type, :string
  end
end
