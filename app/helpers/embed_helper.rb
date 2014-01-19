module EmbedHelper
  require 'pathname'
  require 'open-uri'

  def inline_stylesheet args={}
    args = args.to_s
    local_asset = Rails.application.assets.find_asset(args).to_s
    script =  local_asset unless local_asset.empty?
    script = open args if args =~ /^https?\:\/\//
    "<style>#{script}</style>".html_safe
  end

  def inline_javascript args={}
    args = args.to_s
    local_asset = Rails.application.assets.find_asset(args).to_s
    script = local_asset unless local_asset.empty?
    script = open args if args =~ /^https?\:\/\//
    "<script>#{script}</script>".html_safe
  end

end
