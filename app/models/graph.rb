class Graph < ActiveRecord::Base
  @types = %w(collapsible_force_layout spacetree_layout)
  validates :setting, inclusion: {  in: @types }, :allow_nil => false, :allow_false => false

  def self.types
    @types
  end
end
