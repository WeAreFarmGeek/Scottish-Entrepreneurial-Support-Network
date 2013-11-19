class CreateOrganisationsSearches < ActiveRecord::Migration
  def change
    create_table :organisations_searches, :id => false do |t|
      t.integer :organisation_id
      t.integer :search_id
    end
  end
end
