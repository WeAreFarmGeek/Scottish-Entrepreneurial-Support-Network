class Header < ActiveRecord::Base
  has_attached_file :image, :styles => { :thumb => "128x128#" }
end
