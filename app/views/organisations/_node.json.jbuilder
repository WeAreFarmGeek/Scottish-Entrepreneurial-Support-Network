require 'digest/sha1'

json.id Digest::SHA1.hexdigest("#{node.id}-#{node.name}-#{node.blurb}")
json.name node.name
json.data do |json|
  json.blurb node.blurb
  json.logo do |json|
    json.thumb    asset_url(node.logo(:thumb))
    json.original asset_url(node.logo.url)
  end
  json.tags node.tags.select(:name).inject([]) {|i,j| i.push j.name }
end
json.children node.children do |json, node|
  json.partial! 'node', node: node
end
