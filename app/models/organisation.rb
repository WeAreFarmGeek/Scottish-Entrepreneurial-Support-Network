class Organisation < ActiveRecord::Base
	has_attached_file :logo, :styles => { :medium => "300x300#", :thumb => "101x100#" }, :default_url => "node.png"
	has_many :children, :class_name => "Organisation", :foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Organisation"
  has_many :search_types, :through => :searches
  has_and_belongs_to_many :searches
  accepts_nested_attributes_for :searches
end
