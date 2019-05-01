class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.to_slug(string)
    string.parameterize.truncate(80, omission: '')
  end
end
