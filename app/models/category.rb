class Category < Tag
  self.default_scopes = [] # Remove the parent scope from this model
end
