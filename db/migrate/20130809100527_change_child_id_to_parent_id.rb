class ChangeChildIdToParentId < ActiveRecord::Migration
  def change
	  add_column    :organisations, :parent_id, :integer
	  remove_column :organisations, :child_id
  end
end
