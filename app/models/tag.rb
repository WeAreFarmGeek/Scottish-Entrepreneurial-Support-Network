class Tag < ActiveRecord::Base
  default_scope { where type: nil } # Remove the child STI tables from all results
end
