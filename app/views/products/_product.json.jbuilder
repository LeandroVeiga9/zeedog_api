json.extract! product, :id, :internal_name, :external_name, :description, :manufacturer, :active, :created_at, :updated_at
json.skus product.skus, partial: "skus/sku", as: :sku
json.url product_url(product, format: :json)
