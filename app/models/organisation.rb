class Organisation < ActiveRecord::Base
	has_attached_file :logo, :styles => { :medium => "300x300#", :thumb => "101x100#" }
	has_many :children, :class_name => "Organisation", :foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Organisation"
	has_and_belongs_to_many :tags
	has_and_belongs_to_many :categories, association_foreign_key: 'tag_id'
end
