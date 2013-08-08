class Organisation < ActiveRecord::Base
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_one :parent, :class_name => "Organisation", :foreign_key => "id"
end
