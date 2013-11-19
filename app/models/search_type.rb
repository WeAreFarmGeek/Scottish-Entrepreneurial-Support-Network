class SearchType < ActiveRecord::Base
  has_many :searches

  def self.defaults
    defaults = %w[target offering]
    defaults.each {|d| SearchType.create(:name => d) }
  end

  def pretty_name
    self.name.downcase.gsub(' ', '_')
  end

end
