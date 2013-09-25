require 'digest/sha1'

json.id Digest::SHA1.hexdigest("#{node.id}-#{node.name}-#{node.blurb}")
json.name node.name
json.data do |json|
  json.blurb simple_format node.blurb
  json.logo do |json|
    if node.logo.exists?
      json.thumb    asset_url(node.logo(:thumb))
      json.original asset_url(node.logo.url)
    else
      json.thumb image_url "missing.png"
      json.original image_url "missing.png"
    end
  end
  json.tags node.tags.select(:name).inject([]) {|i,j| i.push j.name }
  json.categories node.categories.select(:name).inject([]) {|i,j| i.push j.name }
  json.url node.url
end
json.children node.children do |json, node|
  json.partial! 'node', node: node
end
