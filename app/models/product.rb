class Product < ApplicationRecord
  has_many :skus

  before_save :save_name_slug

  private
    def save_name_slug
      self.internal_name = external_name.parameterize
    end
end
