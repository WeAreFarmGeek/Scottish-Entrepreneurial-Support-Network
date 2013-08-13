class CreateOrganisationsTags < ActiveRecord::Migration
  def change
    create_table :organisations_tags do |t|
      t.integer :organisation_id
      t.integer :tag_id
    end
  end
end
