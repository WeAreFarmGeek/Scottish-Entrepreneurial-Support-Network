json.extract! @organisation, :id, :name, :blurb

json.logo_original  asset_url(@organisation.logo.url)
json.logo_medium    asset_url(@organisation.logo(:medium))
json.logo_thumb     asset_url(@organisation.logo(:thumb))

if @organisation.child_id.to_s == ""
	json.child nil
	json.child_id nil
else
	json.child_id @organisation.child_id
	json.child organisation_url(:id => @organisation.child_id, format: :json)
end
