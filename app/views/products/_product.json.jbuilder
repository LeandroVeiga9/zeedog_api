json.extract! product, :id, :internal_name, :external_name, :description, :manufacturer, :active, :created_at, :updated_at
json.url product_url(product, format: :json)