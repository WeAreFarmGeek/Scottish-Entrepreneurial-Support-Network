class Graph < ActiveRecord::Base
  validates :setting, inclusion: {  in: %w(collapsible_force_layout spacetree_layout) }, :allow_nil => false, :allow_false => false
end
