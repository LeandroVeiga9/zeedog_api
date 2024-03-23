class Product < ApplicationRecord
  has_many :skus, dependent: :destroy

  before_save :save_name_slug

  private
    def save_name_slug
      self.internal_name = external_name.parameterize
    end
end
