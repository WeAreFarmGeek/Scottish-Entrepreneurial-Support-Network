json.array!(@organisations) do |organisation|
  json.extract! organisation, :id, :name, :blurb

  json.logo_original  asset_url(organisation.logo.url)
  json.logo_medium    asset_url(organisation.logo(:medium))
  json.logo_thumb     asset_url(organisation.logo(:thumb))

  if organisation.parent_id.to_s == ""
    json.parent nil
    json.parent_id nil
  else
    json.parent organisation_url(:id => organisation.parent_id, format: :json)
    json.parent_id organisation.parent_id
  end
  
  json.url organisation_url(organisation, format: :json)
end
