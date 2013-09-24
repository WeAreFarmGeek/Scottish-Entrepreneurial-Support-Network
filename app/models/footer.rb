class Footer < ActiveRecord::Base
  has_attached_file :image, :styles => { :thumb => "280x65#" }
end
