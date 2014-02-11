class EnforceAutoincrementingIdInHeaders < ActiveRecord::Migration
  def change
    remove_column :headers, :id
    add_column :headers, :id, :primary_key
  end
end
